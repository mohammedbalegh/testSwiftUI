//
//  RequestBuilder.swift
//  PaySkyTask
//
//  Created by Balegh on 06/12/2024.
//

import Foundation

extension RequestBase {
    
    // MARK: URLRequest Generator
    //
    func asURLRequest() -> URLRequest {
        var component: URLComponents = URLComponents()
        component.scheme = self.scheme
        component.host = self.baseURL
        component.port = self.port
        component.path = self.path
        component.queryItems = self.queryItems

        var urlRequest = URLRequest(url: component.url!)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: self.body ?? [":" : ""])
        self.headers?.forEach({
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        })
        return urlRequest
    }
    
}
