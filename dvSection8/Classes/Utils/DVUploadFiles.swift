//
//  DVUploadFiles.swift
//  dvSection8
//
//  Created by MJ Roldan on 17/01/2018.
//

import Foundation
import MobileCoreServices

public class DVUploadFiles: NSObject {
    
    public class var shared: DVUploadFiles {
        struct Static {
            static let instance: DVUploadFiles = DVUploadFiles()
        }
        return Static.instance
    }
    
    private lazy var api: DVAPI = {
        return DVAPI()
    }()
    
    public func request(_ requests: URLRequest, success: @escaping ResponseSuccessBlock, failed: @escaping ResponseFailedBlock) {
        self.api.dataRequest(requests, success: { (response) in
            print(response)
            success(response)
        }, failed: { (errorCode) in
            print(errorCode)
            failed(errorCode)
        })
    }
    
    public func createRequest(with url: URL,
                              params: Paremeters? = nil,
                              headers: HTTPHeaders? = nil,
                              filePathKey: String,
                              paths: [String]) throws -> URLRequest {
        
        let boundary = generateBoundaryString()
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = try createBody(with: params, filePathKey: filePathKey, paths: paths, boundary: boundary)
        
        return urlRequest
    }
    
    private func createBody(with parameters: Paremeters?, filePathKey: String, paths: [String], boundary: String) throws -> Data {
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        for path in paths {
            guard let url = URL(string: path) else { return body}
            let filename = url.lastPathComponent
            do {
                let data = try Data(contentsOf: url)
                let mimetype = mimeType(for: path)
                
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: \(mimetype)\r\n\r\n")
                body.append(data)
                body.append("\r\n")
            } catch {
                print("Invalid data")
            }
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func mimeType(for path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream";
    }
    
}

