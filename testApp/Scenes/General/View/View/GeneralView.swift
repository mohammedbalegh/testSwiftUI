import SwiftUI
import Combine

struct GeneralView: View {
    @EnvironmentObject var router: Router
    @StateObject var gameState = GameState.shared
    @StateObject var viewModel: GeneralViewModel
    @State private var hasLoadedData = false
    @State private var selectedQuestion: QuestionEntity?
    @State private var showingQuestionDetail = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView(wrongAnswers: gameState.wrongAnswers, correctAnswers: gameState.correctAnswers)
            
            // Content
            ContentView(
                viewModel: viewModel,
                gameState: gameState,
                hasLoadedData: $hasLoadedData,
                selectedQuestion: $selectedQuestion,
                showingQuestionDetail: $showingQuestionDetail
            )
        }
        .onAppear {
            if !hasLoadedData {
                viewModel.getQuestions()
                hasLoadedData = true
            }
        }
        .overlay(
            Group {
                if let question = selectedQuestion, showingQuestionDetail {
                    QuestionDetailView(
                        question: question,
                        isPresented: $showingQuestionDetail,
                        gameState: gameState
                    )
                    .netflixTransition(isPresented: showingQuestionDetail) {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showingQuestionDetail = false
                            selectedQuestion = nil
                        }
                    }
                }
            }
        )
    }
}

// MARK: - Header View
private struct HeaderView: View {
    let wrongAnswers: Int
    let correctAnswers: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("Wrong Questions: \(wrongAnswers)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                Spacer()
                Text("Correct answers: \(correctAnswers)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)
        }
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Content View
private struct ContentView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: GeneralViewModel
    @ObservedObject var gameState: GameState
    @Binding var hasLoadedData: Bool
    @Binding var selectedQuestion: QuestionEntity?
    @Binding var showingQuestionDetail: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.model.indices, id: \.self) { index in
                        if let question = viewModel.model[index].question {
                            QuestionCardView(
                                question: question,
                                onTap: {
                                    selectedQuestion = viewModel.model[index]
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        showingQuestionDetail = true
                                    }
                                }
                            )
                            .onAppear {
                                if index == viewModel.model.count - 1 && !viewModel.isLoadingMore && !viewModel.isLoading {
                                    viewModel.loadMoreQuestions()
                                }
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))

                if viewModel.isLoadingMore {
                    LoadingIndicatorView()
                }
            }
            .blur(radius: viewModel.isLoading && viewModel.model.isEmpty ? 3 : 0)

            if viewModel.isLoading && viewModel.model.isEmpty {
                FullScreenLoadingView()
            }
        }
    }
}

// MARK: - Question Card View
private struct QuestionCardView: View {
    let question: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(question)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
        }
        .buttonStyle(QuestionButtonStyle())
        .frame(minHeight: 24)
    }
}

// MARK: - Loading Views
private struct LoadingIndicatorView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .scaleEffect(0.8)
            Spacer()
        }
        .padding()
    }
}

private struct FullScreenLoadingView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
    }
}

// MARK: - Question Button Style
struct QuestionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.primary.opacity(0.2), radius: 8, x: 0, y: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
} 
