//
//  GeneralUseCase.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//


import Foundation
import Combine

protocol GeneralUseCaseUseCaseProtocol {
    func getQuestions(amount: Int) -> AnyPublisher<[QuestionEntity], NetworkError>
}

class GeneralUseCase: GeneralUseCaseUseCaseProtocol {

    private let generalRepo: GeneralRepoInterFace
    
    init(
        generalRepo: GeneralRepoInterFace = GeneralRepo()
    ) {
        self.generalRepo = generalRepo
    }

    func getQuestions(amount: Int = 10) -> AnyPublisher<[QuestionEntity], NetworkError> {
        return generalRepo.getQuestions(amount: amount).map({ models in
            (models.results ?? []).map { model in
                QuestionEntity(
                    difficulty: model.difficulty,
                    question: model.decodedQuestion,
                    correctAnswer: model.decodedCorrectAnswer,
                    allAnswers: ([model.decodedCorrectAnswer].compactMap { $0 } + (model.decodedIncorrectAnswers ?? [])).shuffled()
                )
            }
        }).eraseToAnyPublisher()
    }
}
