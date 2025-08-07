//
//  GeneralRepo.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//

import Combine

struct GeneralRepo: GeneralRepoInterFace {

    private let networkImplementation: GeneralNetworkProtocol

    // MARK: - Initializer
    init(
        networkImplementation: GeneralNetworkProtocol = GeneralNetwork()
    ) {
        self.networkImplementation = networkImplementation
    }

    func getQuestions(amount: Int) -> AnyPublisher<QuestionBaseModel, NetworkError> {
        networkImplementation.getQuestions(amount: amount).eraseToAnyPublisher()
    }
}
