//
//  NetworkManager.swift
//  PaySkyTask
//
//  Created by Balegh on 06/12/2024.
//

import Foundation
import Combine

final class NetworkManager: Network {
    
    private let jsonDecoder = JSONDecoder()

    // MARK: - Return Data
    func execute<T: Decodable>(_ request: RequestBase, model: T.Type) -> AnyPublisher<T, NetworkError> {
        
        let urlRequest = request.asURLRequest()
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                return try self.verifyResponse(response, data: data)
            }
            .decodeResponse(using: jsonDecoder)
            .mapError { (error: Error) -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError(errorType: .unknownError)
                }
            }.eraseToAnyPublisher()
    }
    
    private func verifyResponse(_ response: URLResponse, data: Data) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError(errorType: .invalidResponse)
        }
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 429:
            throw NetworkError(errorType: .customError("Rate limit exceeded. Please wait a moment before trying again."))
        case 400...499:
            throw NetworkError(errorType: .serverError)
        case 500...599:
            throw NetworkError(errorType: .serverError)
        default:
            throw NetworkError(errorType: .unknownError)
        }
    }
}

extension Publisher where Output == Data, Failure == Error {
    func decodeResponse<T: Decodable, E: Error>(using decoder: JSONDecoder) -> AnyPublisher<T, E> {
        return tryMap { data in
            return try decoder.decode(T.self, from: data)
        }
        .mapError { $0 as! E }
        .eraseToAnyPublisher()
    }
}
