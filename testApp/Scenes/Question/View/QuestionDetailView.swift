//
//  QuestionDetailView.swift
//  testApp
//
//  Created by mohammed balegh on 07/08/2025.
//

import SwiftUI

struct QuestionDetailView: View {
    let question: QuestionEntity
    @Binding var isPresented: Bool
    @State private var selectedAnswer: String = ""
    @State private var showResult: Bool = false
    @State private var resultScale: CGFloat = 0.0
    @State private var animationTask: Task<Void, Never>?
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    // Cancel any pending animations
                    animationTask?.cancel()
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 24)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(question.question ?? "No question")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                    
                    VStack(spacing: 12) {
                        ForEach(question.allAnswers, id: \.self) { answer in
                            RadioButton(
                                label: answer,
                                isSelected: selectedAnswer == answer,
                                action: {
                                    selectedAnswer = answer
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    if !selectedAnswer.isEmpty {
                        Button(action: handleSubmit) {
                            Text("Submit Answer")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.accentColor)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .safeAreaInset(edge: .top) {
            Color.clear.frame(height: 0)
        }
        .overlay(
            Group {
                if showResult {
                    ResultOverlayView(
                        isCorrect: isCorrectAnswer(),
                        scale: resultScale
                    )
                }
            }
        )
        .onDisappear {
            // Cancel any pending animations when view disappears
            animationTask?.cancel()
        }
    }
    
    private func isCorrectAnswer() -> Bool {
        return selectedAnswer == question.correctAnswer
    }
    
    private func handleSubmit() {
        showResult = true
        
        if isCorrectAnswer() {
            gameState.incrementCorrect()
        } else {
            gameState.incrementWrong()
        }
        
        // Cancel any existing animation task
        animationTask?.cancel()
        
        // Create new animation task
        animationTask = Task {
            withAnimation(.bouncy(duration: 0.8, extraBounce: 0.3)) {
                resultScale = 1.0
            }
            
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
            
            if !Task.isCancelled {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    resultScale = 0.0
                }
                
                try? await Task.sleep(nanoseconds: 400_000_000) // 0.4 seconds
                
                if !Task.isCancelled {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isPresented = false
                    }
                }
            }
        }
    }
}

// MARK: - Result Overlay View
private struct ResultOverlayView: View {
    let isCorrect: Bool
    let scale: CGFloat
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(isCorrect ? .green : .red)

                Text(isCorrect ? "Correct 🎉" : "Wrong ❌")
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .foregroundColor(isCorrect ? .green : .red)
            }
            .scaleEffect(scale)
            .opacity(scale)
        }
    }
}
