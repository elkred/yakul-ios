import SwiftUI

/// The primary circular progress view style for `yakul`.
public struct PrimaryCircularProgressViewStyle: ProgressViewStyle {
    
    // MARK: - Private State
    
    @State private var isLoading = false
    
    // MARK: - Body

    public func makeBody(configuration: Configuration) -> some View {
        return ZStack {
            Circle()
                .stroke(gradient, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(maxWidth: 60, maxHeight: 60)
                .rotationEffect(.degrees(isLoading ? 360 : 0))
                .onAppear {
                    withAnimation(
                        Animation
                            .linear(duration: 1)
                            .repeatForever(autoreverses: false)
                    ) {
                        isLoading.toggle()
                    }
                }
        }
    }
    
    /// Gradient styling for loader.
    private var gradient: AngularGradient {
        .init(
            gradient: Gradient(colors: [.black, .black.opacity(0)]),
            center: .center,
            startAngle: .degrees(270),
            endAngle: .degrees(0)
        )
    }
}

#Preview {
    ProgressView().progressViewStyle(PrimaryCircularProgressViewStyle())
}
