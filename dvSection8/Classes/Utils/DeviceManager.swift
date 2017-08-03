//
//  DeviceManager.swift
//  Rush
//
//  Created by MJ Roldan on 31/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import UIKit

struct DeviceManager {
    // get model
    let model = UIDevice().model
    // get platform
    let platform = UIDevice().systemName
    // get platform version
    let platformVersion = UIDevice().systemVersion
    // get deviceid or uuid
    let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    // get device name from bundle
    var appName: String {
        get {
            if let bundle = Bundle.main.infoDictionary,
                let appname = bundle["CFBundleDisplayName"] as? String {
                return appname
            }
            return ""
        }
    }
    // get app version from bundle
    var appVersion: String {
        get {
            if let bundle = Bundle.main.infoDictionary,
                let appversion = bundle["CFBundleShortVersionString"] as? String {
                return appversion
            }
            return ""
        }
    }
}
