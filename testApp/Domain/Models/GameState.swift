import Foundation

class GameState: ObservableObject {
    static let shared = GameState()
    
    @Published var wrongAnswers: Int = 0
    @Published var correctAnswers: Int = 0
    
    private init() {} // Make it a singleton
    
    func reset() {
        wrongAnswers = 0
        correctAnswers = 0
    }
    
    func incrementCorrect() {
        correctAnswers += 1
    }
    
    func incrementWrong() {
        wrongAnswers += 1
    }
} 