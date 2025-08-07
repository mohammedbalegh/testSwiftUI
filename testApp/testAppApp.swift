//
//  testAppApp.swift
//  testApp
//
//  Created by mohammed balegh on 05/08/2025.
//

import SwiftUI

@main
struct testAppApp: App {
    @StateObject var router = Router()
    @State var appScreen: AppTabs = .general

    var body: some Scene {
        WindowGroup {
            AppTabView(selection: $appScreen)
                .environmentObject(router)
        }
    }
}
