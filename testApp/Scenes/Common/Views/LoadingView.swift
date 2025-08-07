import SwiftUI

struct LoadingView: View {
    let scale: CGFloat
    let text: String?
    
    init(scale: CGFloat = 1.0, text: String? = nil) {
        self.scale = scale
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(scale)
            
            if let text = text {
                Text(text)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Loading View Modifiers
extension View {
    func loadingOverlay(isLoading: Bool, text: String? = nil) -> some View {
        self.overlay(
            Group {
                if isLoading {
                    LoadingView(text: text)
                        .background(Color(.systemBackground).opacity(0.8))
                }
            }
        )
    }
} 