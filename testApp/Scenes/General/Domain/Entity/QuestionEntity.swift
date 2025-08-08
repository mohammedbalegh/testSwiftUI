import Foundation

struct QuestionEntity: Hashable {
    let difficulty : String?
    let question : String?
    let correctAnswer : String?
    let allAnswers: [String]
} 
