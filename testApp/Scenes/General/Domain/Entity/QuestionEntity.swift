import Foundation

struct QuestionEntity: Hashable {
    let difficulty : String?
    let question : String?
    let correctAnswer : String?
    let allAnswers: [String]
    
    // Computed properties for decoded text
    var decodedQuestion: String? {
        return question?.htmlDecoded
    }
    
    var decodedCorrectAnswer: String? {
        return correctAnswer?.htmlDecoded
    }
    
    var decodedAllAnswers: [String] {
        return allAnswers.map { $0.htmlDecoded }
    }
} 