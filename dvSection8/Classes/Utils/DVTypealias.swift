//
//  Typealias.swift
//  Rush
//
//  Created by MJ Roldan on 05/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import Foundation

public typealias StringDictionary = Dictionary<String, String>
public typealias JSONDictionary = Dictionary<String, Any>
public typealias JSONDictionaryArray = [JSONDictionary]
public typealias StringArray = [(String, String)]
public typealias Paremeters = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias ResponseSuccessBlock = (JSONDictionary) -> ()
public typealias ResponseFailedBlock = (APIErrorCode) -> ()

