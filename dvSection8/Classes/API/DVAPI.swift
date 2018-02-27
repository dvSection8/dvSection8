//
//  API.swift
//  Rush
//
//  Created by MJ Roldan on 05/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import Foundation
import ReachabilitySwift

// MARK: - HTTPMethod
public enum HTTPMethod: String {
    case post   = "POST"
    case get    = "GET"
}

public class DVAPI: NSObject {

    private let session :URLSession?
    fileprivate var reachability :Reachability?

    override public init() {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 45.0

        self.session = URLSession(configuration: configuration)
        self.reachability = Reachability()
        super.init()
    }

    private func urlRequest(_ requests: DVAPIRequests) -> URLRequest {
        var _urlRequest = URLRequest(url: requests.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 45.0)
        _urlRequest.httpMethod = requests.method.rawValue
        _urlRequest.allHTTPHeaderFields = requests.headers
        _urlRequest.allowsCellularAccess = true
        
        if let parameters = requests.parameters {
            _urlRequest.httpBody = DVAPIHelper.shared.query(parameters).data(using: .utf8, allowLossyConversion: false)
        }
        
        return _urlRequest
    }
    
    public func request(_ requests: DVAPIRequests,
                 success: @escaping ResponseSuccessBlock,
                 failed: @escaping ResponseFailedBlock) {

        if self.canConnect() {
            guard let _ = requests.url else {
                DispatchQueue.main.async { failed(.invalidURL) }
                return
            }

            let urlRequest = self.urlRequest(requests)
            
            self.dataRequest(urlRequest, success: { (result) in
                DispatchQueue.main.async { success(result) }
            }) { (error) in
                DispatchQueue.main.async { failed(error) }
            }
        }
        else {
            DispatchQueue.main.async { failed(.noInternet) }
        }

    }

    public func dataRequest(_ urlRequest: URLRequest,
                                 success: @escaping ResponseSuccessBlock,
                                 failed: @escaping ResponseFailedBlock) {

        DispatchQueue.global(qos: .utility).async { [weak self] in
            
            var task: URLSessionTask?
            task = self?.session?.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                guard let data = data, error == nil else {
                    // failed
                    if let _error = error as NSError? {
                        let apiError = DVAPIError.urlErrorDomain(_error)
                        DispatchQueue.main.async { failed(apiError) }
                        task?.cancel()
                    }
                    return
                }
                
                do {
                    guard let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONDictionary else {
                        // failed
                        /*if let httpResponse = response as? HTTPURLResponse, let errorCode = DVAPIError.responseStatus(httpResponse) {
                            DispatchQueue.main.async {
                                failed(errorCode)
                            }
                            task?.cancel()
                        } else {
                            DispatchQueue.main.async {
                                failed(.invalidData)
                            }
                            task?.cancel()
                        }*/
                        
                        guard let httpResponse = response as? HTTPURLResponse,
                                let errorCode = DVAPIError.responseStatus(httpResponse) else {
                            DispatchQueue.main.async { failed(.invalidData) }
                            task?.cancel()
                            return
                        }
                        
                        DispatchQueue.main.async { failed(errorCode) }
                        task?.cancel()
                        return
                    }
                    // success
                    DispatchQueue.main.async { success(jsonResult) }
                } catch {
                    // failed
                    DispatchQueue.main.async { failed(.invalidData) }
                    task?.cancel()
                    return
                }
                
            })
            task?.resume()
            
        }
    }

}

extension DVAPI {
    fileprivate func canConnect() -> Bool {
        if let reachable = self.reachability, reachable.isReachableViaWiFi || reachable.isReachableViaWWAN {
            return true
        } else if let reachable = self.reachability {
            if !reachable.isReachable {
                return false
            }
        }
        return false
    }
}
