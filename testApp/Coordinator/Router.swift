//
//  Router.swift
//  testApp
//
//  Created by mohammed balegh on 06/08/2025.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path: [AppPages] = []
}

enum AppPages: Hashable {
    case question(QuestionEntity)
}

