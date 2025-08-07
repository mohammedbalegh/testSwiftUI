import SwiftUI

struct QuestionsView: View {
    @EnvironmentObject var router: Router
    @State var question: QuestionEntity
    @State var selectedAnswer: String
    @State var showResult: Bool = false
    @State var circleSize: CGFloat = 0
    @ObservedObject var gameState: GameState
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                QuestionHeaderView(question: question)
                
                AnswerOptionsView(
                    answers: question.allAnswers,
                    selectedAnswer: $selectedAnswer
                )

                Spacer()
                    .frame(height: 48)

                HStack {
                    Spacer()
                    if !selectedAnswer.isEmpty {
                        SubmitButtonView(
                            onSubmit: handleSubmit
                        ).frame(width: 248, height: 64)
                    }
                    Spacer()
                }

                Spacer()
            }
            .padding()

            if showResult {
                ResultOverlayView(
                    isCorrect: isCorrectAnswer(),
                    circleSize: circleSize
                )
            }
        }
        .navigationBarBackButtonHidden(showResult)
    }
    
    private func isCorrectAnswer() -> Bool {
        return selectedAnswer == question.correctAnswer
    }
    
    private func handleSubmit() {
        showResult = true
        
        // Update counters
        if isCorrectAnswer() {
            gameState.incrementCorrect()
        } else {
            gameState.incrementWrong()
        }
        
        // Animate circle
        withAnimation(.bouncy(duration: 0.6)) {
            circleSize = 1000
        }
        
        // Dismiss after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            dismissQuestion()
        }
    }
    
    private func dismissQuestion() {
        if !router.path.isEmpty {
            router.path.removeLast()
        }
    }
}

// MARK: - Question Header View
private struct QuestionHeaderView: View {
    let question: QuestionEntity
    
    var body: some View {
        Text(question.question ?? "No question")
            .font(.headline)
            .padding(.bottom, 16)
    }
}

// MARK: - Answer Options View
private struct AnswerOptionsView: View {
    let answers: [String]
    @Binding var selectedAnswer: String
    
    var body: some View {
        ForEach(answers, id: \.self) { answer in
            RadioButton(
                label: answer,
                isSelected: selectedAnswer == answer,
                action: {
                    selectedAnswer = answer
                }
            )
        }
    }
}

// MARK: - Submit Button View
private struct SubmitButtonView: View {
    let onSubmit: () -> Void
    
    var body: some View {
        Button("Submit Answer", action: onSubmit)
            .buttonStyle(.borderedProminent)
            .padding()
    }
}

// MARK: - Result Overlay View
private struct ResultOverlayView: View {
    let isCorrect: Bool
    let circleSize: CGFloat
    
    var body: some View {
        Circle()
            .fill(isCorrect ? Color.green : Color.red)
            .frame(width: circleSize, height: circleSize)
            .overlay(
                Text(isCorrect ? "Correct!" : "Wrong!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(circleSize > 500 ? 1 : 0)
            )
            .animation(.easeInOut(duration: 0.3), value: circleSize > 500)
    }
} 
