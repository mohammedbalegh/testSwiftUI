//
//  Endpoints.swift
//  PaySkyTask
//
//  Created by Balegh on 06/12/2024.
//

import Foundation

enum Endpoints: RequestBase {
    
    var body: [String : Any]? {
        return nil // No body for GET requests
    }
    
    // MARK: - Properties
    case general(amount: Int = 10)
    case film(amount: Int = 10)
    case music(amount: Int = 10)

    // MARK: - Path
    var path: String {
        return "/api.php"
    }

    // MARK: - Query Items
    var queryItems: [URLQueryItem]? {
        switch self {
        case .general(let amount):
            return [
                URLQueryItem(name: "amount", value: "\(amount)"),
                URLQueryItem(name: "category", value: "9")
            ]
        case .film(let amount):
            return [
                URLQueryItem(name: "amount", value: "\(amount)"),
                URLQueryItem(name: "category", value: "11")
            ]
        case .music(let amount):
            return [
                URLQueryItem(name: "amount", value: "\(amount)"),
                URLQueryItem(name: "category", value: "12")
            ]
        }
    }
}
