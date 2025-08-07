//
//  NetworkConstants.swift
//  PaySkyTask
//
//  Created by Balegh on 06/12/2024.
//

import Foundation

extension RequestBase {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "opentdb.com"
    }
    
    var port: Int? {
        return nil
    }
    
    var headers: [String: String]? {
        return ["accept": "text/plain", "Content-Type": "application/json-patch+json"]
    }
    var method: HTTPMethod {
        return .post
    }
}
