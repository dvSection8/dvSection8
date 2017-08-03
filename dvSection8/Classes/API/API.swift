//
//  API.swift
//  Rush
//
//  Created by MJ Roldan on 05/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import Foundation

// MARK: - HTTPMethod
public enum HTTPMethod: String {
    case post   = "POST"
    case get    = "GET"
}

public class API: NSObject {

    fileprivate let session :URLSession?
    fileprivate var reachability :Reachability?

    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 45.0

        self.session = URLSession(configuration: configuration)
        self.reachability = Reachability()
        super.init()
    }

    public func request(_ requests: APIRequests,
                 success: @escaping ResponseSuccessBlock,
                 failed: @escaping ResponseFailedBlock) {

        if self.canConnect() {
            guard let _ = requests.url else {
                failed(.invalidURL)
                return
            }

            let urlRequest = self.urlRequest(requests)
            
            self.dataRequest(urlRequest, success: { (result) in
                success(result)
            }) { (error) in
                failed(error)
            }
        }
        else {
            failed(.noInternet)
        }

    }

    private func urlRequest(_ requests: APIRequests) -> URLRequest {
        var _urlRequest = URLRequest(url: requests.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 45.0)
        _urlRequest.httpMethod = requests.method.rawValue
        _urlRequest.allHTTPHeaderFields = requests.headers
        _urlRequest.allowsCellularAccess = true

        if let parameters = requests.parameters {
            _urlRequest.httpBody = APIHelper.shared.query(parameters).data(using: .utf8, allowLossyConversion: false)
        }
        
        return _urlRequest
    }

    private func dataRequest(_ urlRequest: URLRequest,
                                 success: @escaping ResponseSuccessBlock,
                                 failed: @escaping ResponseFailedBlock) {

        self.session?.dataTask(with: urlRequest, completionHandler: { (data, response, error) in

            guard let data = data, error == nil else {
                // failed
                if let _error = error as NSError? {
                    let apiError = APIError.urlErrorDomain(_error)
                    failed(apiError)
                }
                return
            }

            do {
                guard let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONDictionary else {
                    // failed
                    if let httpResponse = response as? HTTPURLResponse, let errorCode = APIError.responseStatus(httpResponse) {
                        failed(errorCode)
                    } else {
                        failed(.invalidData)
                    }
                    return
                }
                // success
                success(jsonResult)
            } catch {
                // failed
                failed(.invalidData)
            }

        }).resume()
    }

}

extension API {
    public func canConnect() -> Bool {
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
