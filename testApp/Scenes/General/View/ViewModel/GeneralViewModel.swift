//
//  GeneralViewModel.swift
//  testApp
//
//  Created by mohammed balegh on 06/08/2025.
//

import Foundation
import Combine


class GeneralViewModel: ObservableObject {

    private let generalUseCase: GeneralUseCaseUseCaseProtocol

    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var model: [QuestionEntity] = []
    @Published var errorMessage: String = ""
    
    private var currentAmount: Int = 20
    private var hasMoreData: Bool = true
    private let incrementAmount: Int = 10 

    private var cancellable = Set<AnyCancellable>()

    init(generalUseCase: GeneralUseCaseUseCaseProtocol = GeneralUseCase()) {
        self.generalUseCase = generalUseCase
    }

    func getQuestions() {
        isLoading = true
        currentAmount = 20 // Match the initial value
        hasMoreData = true

        generalUseCase
            .getQuestions(amount: currentAmount)
            .receive(on: DispatchQueue.main)
            .singleOutput(with: &cancellable) { [weak self] result in
                guard let self else { return }
                self.isLoading = false
                switch result {
                case .success(let success):
                    self.model = success
                case .failure(let failure):
                    self.errorMessage = failure.errorDescription ?? failure.localizedDescription
                }
            }
    }
    
    func loadMoreQuestions() {
        guard hasMoreData && !isLoadingMore && !isLoading else {
            return 
        }
        
        isLoadingMore = true
        currentAmount += incrementAmount
        
        // Add a small delay to avoid rate limiting
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self else { return }
            
            self.generalUseCase
                .getQuestions(amount: self.currentAmount)
                .receive(on: DispatchQueue.main)
                .singleOutput(with: &self.cancellable) { [weak self] result in
                    guard let self else { return }
                    self.isLoadingMore = false
                    switch result {
                    case .success(let success):
                        if success.count <= self.model.count {
                            self.hasMoreData = false
                        } else {
                            self.model = success // Replace with new larger dataset
                        }
                    case .failure(let failure):
                        self.errorMessage = failure.errorDescription ?? failure.localizedDescription
                        self.currentAmount -= self.incrementAmount // Revert on failure
                    }
                }
        }
    }
}
