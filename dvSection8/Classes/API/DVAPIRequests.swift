//
//  Request.swift
//  Rush
//
//  Created by MJ Roldan on 06/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import Foundation

public struct DVAPIRequests {
    var method: HTTPMethod = .get
    var url: URL? = nil
    var parameters: Paremeters? = nil
    var headers: HTTPHeaders? = nil
    
    public init(_ method: HTTPMethod, url: URL? = nil, parameters: Paremeters? = nil, headers: HTTPHeaders? = nil) {
        self.method = method
        self.url = url
        self.parameters = parameters
        self.headers = headers
    }
}


