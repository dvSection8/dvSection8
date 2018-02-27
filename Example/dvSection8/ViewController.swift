//
//  ViewController.swift
//  dvSection8
//
//  Created by dvSection8 on 08/03/2017.
//  Copyright (c) 2017 dvSection8. All rights reserved.
//

import UIKit
import dvSection8

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DVForceUpdate.shared.getAppStoreDetailsWith(territory: .all, appId: 582901861, success: { (response) in
            print(response)
        }) { (errorCode) in
            print(errorCode)
        }
        
        DVForceUpdate.shared.checkAppVersion(territory: .all, appId: 582901861) { (notes) in
            print(notes)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

