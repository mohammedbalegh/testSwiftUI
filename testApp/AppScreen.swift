//
//  ContentView.swift
//  testApp
//
//  Created by mohammed balegh on 05/08/2025.
//

import SwiftUI

struct AppTabView: View {
    @EnvironmentObject var router: Router
    @Binding var selection: AppTabs

    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $selection) {
                ForEach(AppTabs.allCases) { screen in
                    screen.destination
                        .tabItem {
                            screen.icon
                            screen.label
                        }
                }
            }
            .navigationDestination(for: AppPages.self) { page in
                switch page {
                case .question(let model):
                    QuestionsView(
                        question: model, 
                        selectedAnswer: "",
                        gameState: GameState.shared
                    )
                }
            }
        }
    }
}

//#Preview {
//    AppTabView(selection: .constant(.general))
//        .environment(Router())
//}
