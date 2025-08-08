//
//  RadioButton.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//

import SwiftUI

struct RadioButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.title2)
                    .foregroundColor(isSelected ? .accentColor : .secondary)
                Text(label)
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 24)
    }
}
