//
//  Extensions.swift
//  dvSection8
//
//  Created by MJ Roldan on 22/02/2018.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
