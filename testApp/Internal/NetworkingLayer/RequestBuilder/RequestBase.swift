//
//  RequestBase.swift
//  PaySkyTask
//
//  Created by Balegh on 06/12/2024.
//

import Foundation

protocol RequestBase {
    var baseURL: String {get}
    var scheme: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var headers: [String: String]? {get}
    var body: [String: Any]? {get}
    var port: Int? {get}
    var queryItems: [URLQueryItem]? {get}
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case options = "OPTIONS"
}
