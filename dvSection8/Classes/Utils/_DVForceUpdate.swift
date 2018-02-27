//
//  AppVersion.swift
//  Rush
//
//  Created by MJ Roldan on 31/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import Foundation

/*public enum iTunesLookUp: String {
    case ph = "https://itunes.apple.com/ph/lookup?id="
    case all = "https://itunes.apple.com/lookup?id="
}

public struct _DVForceUpdate {
    private lazy var api: DVAPI = {
        return DVAPI()
    }()
    var itunesID: Any? = nil
    var lookUpTerritory: String? = nil
    
    public init(itunesID id: Any? = nil, territory lookUp: iTunesLookUp) {
        self.itunesID = id
        self.lookUpTerritory = lookUp.rawValue
    }
    
    /**
     Set content-type in HTTP header
     */
    fileprivate func contentType() -> String {
        let boundaryConstant = "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy";
        let contentType = "multipart/form-data; boundary=" + boundaryConstant
        return contentType
    }
    
    /**
     This function will result block for lookup itunes api to get the json data
     */
    public func getAppStoreDetails(_ value: @escaping ResponseSuccessBlock, failed: @escaping ResponseFailedBlock) {
        let url = URL(string: "\(self.lookUpTerritory ?? "")" + "\(self.itunesID ?? "")")
        let headers = ["content-Type": self.contentType()]
        let requests = DVAPIRequests(.post, url: url, parameters: nil, headers: headers)
        self.api.request(requests, success: { (results) in
            if let results = results["results"] as? [Any] {
                if results.count > 0 {
                    if let dict = results[0] as? JSONDictionary {
                        value(dict)
                    }
                }
            }
        }, failed: { (errorCode) in
            failed(errorCode)
        })
        
    }
    
    /**
     check the current app store version and current installed app version
     */
    public func checkAppVersion(_ update: @escaping () -> ()) {
        self.getAppStoreDetails({ (result) in
            // get installed app version
            if let appStoreVersion = result["version"] as? String {
                let deviceAppVersion = DVDeviceManager().appVersion
                print("appStoreVersion: \(appStoreVersion), deviceAppVersion: \(deviceAppVersion)")
                // get each version number
                let asvComponents = appStoreVersion.components(separatedBy: ".")
                let davComponents = deviceAppVersion.components(separatedBy: ".")
                var isOutOfVersion = false
                // check if current app store version and app version has not equal
                for v in 0..<min(asvComponents.count, davComponents.count) {
                    let asv :String = asvComponents[v]
                    let dav :String = davComponents[v]
                    if asv != dav {
                        isOutOfVersion = (dav < asv)
                        break
                    }
                }
                // the app version is out to date
                if isOutOfVersion {
                    update()
                }
            }
        }) {_ in
            // Failed
        }
    }
}*/


