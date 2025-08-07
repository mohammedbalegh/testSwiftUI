//
//  QuestionsModel.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//


import Foundation

struct QuestionsModel: Codable, Hashable, Equatable {
	let type : String?
	let difficulty : String?
	let category : String?
	let question : String?
	let correct_answer : String?
	let incorrect_answers : [String]?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case difficulty = "difficulty"
		case category = "category"
		case question = "question"
		case correct_answer = "correct_answer"
		case incorrect_answers = "incorrect_answers"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		difficulty = try values.decodeIfPresent(String.self, forKey: .difficulty)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		question = try values.decodeIfPresent(String.self, forKey: .question)
		correct_answer = try values.decodeIfPresent(String.self, forKey: .correct_answer)
		incorrect_answers = try values.decodeIfPresent([String].self, forKey: .incorrect_answers)
	}
    
    // Computed properties for decoded text
    var decodedQuestion: String? {
        return question?.htmlDecoded
    }
    
    var decodedCorrectAnswer: String? {
        return correct_answer?.htmlDecoded
    }
    
    var decodedIncorrectAnswers: [String]? {
        return incorrect_answers?.map { $0.htmlDecoded }
    }
}
