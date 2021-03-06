//
//  DeviceManager.swift
//  Rush
//
//  Created by MJ Roldan on 31/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import UIKit

public struct DVDeviceManager {
    
    public static let shared = DVDeviceManager()
    
    // get model
    public static let model = UIDevice().model
    // get platform
    public static let platform = UIDevice().systemName.lowercased()
    // get platform version
    public static let platformVersion = UIDevice().systemVersion
    // get deviceid or uuid
    public static let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    // get device name from bundle
    public static var appName: String {
        get {
            if let bundle = Bundle.main.infoDictionary,
                let appname = bundle["CFBundleDisplayName"] as? String {
                return appname
            }
            return ""
        }
    }
    // get app version from bundle
    public static var appVersion: String {
        get {
            if let bundle = Bundle.main.infoDictionary,
                let appversion = bundle["CFBundleShortVersionString"] as? String {
                return appversion
            }
            return ""
        }
    }
}
