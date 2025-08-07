//
//  GeneralNetwork.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//

import Combine

protocol GeneralNetworkProtocol {
    func getQuestions(amount: Int) -> AnyPublisher<QuestionBaseModel, NetworkError>
}

class GeneralNetwork: GeneralNetworkProtocol {
    let network: Network

    init(network: Network = NetworkManager()) {
        self.network = network
    }

    func getQuestions(amount: Int) -> AnyPublisher<QuestionBaseModel, NetworkError> {
        let request = Endpoints.general(amount: amount)
        let model = QuestionBaseModel.self
        let response = network.execute(request, model: model)
        return response
    }
}
