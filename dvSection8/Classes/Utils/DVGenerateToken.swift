//
//  DVGenerateToken.swift
//  dvSection8
//
//  Created by MJ Roldan on 17/01/2018.
//

import Foundation

public struct DVGenerateToken {
    
    public static let shared = DVGenerateToken()
    
    // Generate Bearer Token
    public func generateToken(_ url: URL?, key: String, secret: String, success: @escaping (JSONDictionary) -> (), failed: @escaping (APIErrorCode) -> ()) {
        guard let url = url else {return}
        var _urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 45.0)
        _urlRequest.httpMethod = HTTPMethod.post.rawValue
        _urlRequest.allowsCellularAccess = true
        _urlRequest.httpBody = dataEncodedFrom(key: key, secret: key)
        
        DVAPI().dataRequest(_urlRequest, success: { (response) in
            success(response)
        }) { (errorCode) in
            failed(errorCode)
        }
    }
    
    // Convert app key and app secret to data encode
    private func dataEncodedFrom(key: String, secret: String) -> Data? {
        let appkey = "app_key=\(key)"
        let appsecret = "app_secret=\(secret)"
        let params = appkey + "&" + appsecret
        let replaceAllChars = params.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)
        let encoded = replaceAllChars?.data(using: .utf8)
        return encoded
    }
}
