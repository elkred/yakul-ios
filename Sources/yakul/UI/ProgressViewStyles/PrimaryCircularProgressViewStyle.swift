import SwiftUI

@available(iOS 15.0, *)
public struct PrimaryCircularProgressViewStyle: ProgressViewStyle {
    
    public init() { }
    
    @State private var isLoading = false
    
    private var gradient: AngularGradient = .init(
            gradient: Gradient(colors: [.black, .black.opacity(0)]),
            center: .center,
            startAngle: .degrees(270),
            endAngle: .degrees(0)
        )
    

    public func makeBody(configuration: Configuration) -> some View {
        return ZStack {
            Circle()
                .stroke(gradient, style: StrokeStyle(lineWidth: 3, lineCap: .round))
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
}
