//
//  QuestionBaseModel.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//


import Foundation
struct QuestionBaseModel : Codable {
	let response_code : Int?
    let results : [QuestionsModel]?

	enum CodingKeys: String, CodingKey {

		case response_code = "response_code"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		response_code = try values.decodeIfPresent(Int.self, forKey: .response_code)
		results = try values.decodeIfPresent([QuestionsModel].self, forKey: .results)
	}

}
