//
//  NetworkError.swift
//  PaySkyTask
//
//  Created by Balegh on 06/12/2024.
//

import Foundation

struct NetworkError: LocalizedError, Decodable {
    var message: String?
    var specificError: DefaultErrors?
    
    init(errorType: DefaultErrors) {
        self.specificError = errorType
    }
}


enum DefaultErrors: Decodable {
    case noConnection
    case invalidResponse
    case serverError
    case decodingError
    case unknownError
    case customError(String)
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return Localizer.serverError
        case .noConnection:
            return Localizer.noConnection
        case .unknownError:
            return Localizer.unknownError
        case .invalidResponse:
            return Localizer.invalidResponse
        case .decodingError:
            return Localizer.decodingError
        case .customError(let error):
            return error
        }
    }
}
