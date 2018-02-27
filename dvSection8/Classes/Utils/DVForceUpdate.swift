//
//  DVForceUpdate.swift
//  dvSection8
//
//  Created by MJ Roldan on 22/02/2018.
//

import Foundation

public enum Territories: String {
    case ph = "ph/"
    case all = ""
}

public class DVForceUpdate: NSObject {
    
    public class var shared: DVForceUpdate {
        struct Static {
            static let instance: DVForceUpdate = DVForceUpdate()
        }
        return Static.instance
    }
    
    private lazy var api: DVAPI = {
        return DVAPI()
    }()
    
    public func getAppStoreDetailsWith(territory: Territories, appId: Any,
                                       success: @escaping ResponseSuccessBlock,
                                       failed: @escaping ResponseFailedBlock) {
        
        let url = URL(string: "https://itunes.apple.com/\(territory.rawValue)lookup?id=\(appId)")
        let requests = DVAPIRequests(.get, url: url)
        
        self.api.request(requests, success: { (response) in
            success(response)
        }) { (errorCode) in
            failed(errorCode)
        }
    }
    
    public func checkAppVersion(territory: Territories, appId: Any, success: @escaping (String) -> ()) {
        
        self.getAppStoreDetailsWith(territory: territory,
                                    appId: appId,
                                    success: { (response) in
            
            guard let results = response["results"] as? [JSONDictionary] else {
                return
            }
            
            if results.count > 0 {
                
                let version : String = results.first?["version"] as? String ?? ""
                let releaseNotes : String = results.first?["releaseNotes"] as? String ?? ""
                let localVersion : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
                
                if version.compare(localVersion) == ComparisonResult.orderedDescending {
                    DispatchQueue.main.async {
                        success(releaseNotes)
                    }
                }
            }
            
        }) { (errorCode) in
            
        }
    }
}
