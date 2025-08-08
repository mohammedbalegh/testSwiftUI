//
//  NetflixTransition.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//

import SwiftUI

struct NetflixTransition: ViewModifier {
    let isPresented: Bool
    let onDismiss: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            // Background overlay
            if isPresented {
                Color.black
                    .ignoresSafeArea()
                    .onTapGesture {
                        onDismiss()
                    }
                    .transition(.opacity)
            }
            
            content
                .scaleEffect(isPresented ? 1.0 : 0.8)
                .opacity(isPresented ? 1.0 : 0.0)
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isPresented)
        }
    }
}

extension View {
    func netflixTransition(isPresented: Bool, onDismiss: @escaping () -> Void) -> some View {
        modifier(NetflixTransition(isPresented: isPresented, onDismiss: onDismiss))
    }
}
