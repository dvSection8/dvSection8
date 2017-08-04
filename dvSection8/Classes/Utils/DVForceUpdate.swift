//
//  AppVersion.swift
//  Rush
//
//  Created by MJ Roldan on 31/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import Foundation

public enum iTunesLookUp: String {
    case ph = "http://itunes.apple.com/ph/lookup?id="
    case us = "http://itunes.apple.com/lookup?id="
}

public struct DVForceUpdate {
    var api :DVAPI?
    var itunesID: String?
    var lookUpTerritory: String?
    
    public init(itunesID id: String?, lookUp: iTunesLookUp) {
        self.api = DVAPI()
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
     This function will requests for lookup itunes api
     */
    fileprivate func requests() -> DVAPIRequests {
        let url = URL(string: "\(self.lookUpTerritory ?? "")" + "\(self.itunesID ?? "")")
        let headers = ["content-Type": contentType()]
        return DVAPIRequests(.post, url: url, parameters: nil, headers: headers)
    }
    
    /**
     This function will result block for lookup itunes api to get the json data
    */
    fileprivate func lookupApplicationBy(success: @escaping ResponseSuccessBlock,
                                         failed: @escaping ResponseFailedBlock) {
        let requests = self.requests()
        self.api?.request(requests, success: { (results) in
            success(results)
        }, failed: { (errorCode) in
            failed(errorCode)
        })
    }
    
    /** 
     This function will result block for app store version
    */
    fileprivate func getAppStoreVersion(_ version: @escaping (String) -> ()) {
        lookupApplicationBy(success: { (results) in
            if let results = results["results"] as? [Any] {
                if results.count > 0 {
                    if let dict = results[0] as? JSONDictionary, let appStoreVersion = dict["version"] as? String {
                        version(appStoreVersion)
                    }
                }
            }
        }) { (errorCode) in
            version("")
        }
    }
    
    /** 
     check the current app store version and current installed app version
    */
    public func checkAppVersion(_ update: @escaping () -> ()) {
        getAppStoreVersion { (value) in
            // get installed app version
            let deviceAppVersion = DVDeviceManager().appVersion
            print("appStoreVersion: \(value), deviceAppVersion: \(deviceAppVersion)")
            // get each version number
            let asvComponents = value.components(separatedBy: ".")
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
    }
}


