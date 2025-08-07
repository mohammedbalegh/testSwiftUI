//
//  Network.swift
//  PaySkyTask
//
//  Created by Balegh on 06/12/2024.
//

import Combine

protocol Network {
    func execute<T: Codable>(_ request: RequestBase, model: T.Type) -> AnyPublisher<T, NetworkError>
}

