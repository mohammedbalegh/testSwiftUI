//
//  AppTabs.swift
//  testApp
//
//  Created by mohammed balegh on 06/08/2025.
//

import SwiftUI

enum AppTabs: Hashable, Identifiable, CaseIterable {
    case general
    case film
    case music

    var id: AppTabs { self }
}

extension AppTabs {

    @ViewBuilder
    var label: some View {
        switch self {
        case .general:
            Text("General")
        case .film:
            Text("Film")
        case .music:
            Text("Music")
        }
    }

    @ViewBuilder
    var icon: some View {
        switch self {
        case .general:
            Image(systemName: "globe")
        case .film:
            Image(systemName: "film")
        case .music:
            Image( systemName:"music.note")
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .general:
            GeneralView(viewModel: GeneralViewModel())
        case .film:
            FilmView()
        case .music:
            MusicView()
        }
    }
}
