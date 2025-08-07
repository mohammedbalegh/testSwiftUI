//
//  GeneralRepoInterFace.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//

import Combine

protocol GeneralRepoInterFace {
    func getQuestions(amount: Int) -> AnyPublisher<QuestionBaseModel, NetworkError>
}
