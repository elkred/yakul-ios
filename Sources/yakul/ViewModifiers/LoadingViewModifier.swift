import SwiftUI

public struct LoadingViewModifier: ViewModifier {
    
    // MARK: - Init
    
    @Binding public var isLoading: Bool
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .disabled(isLoading)
            .overlay {
                isLoading
                    ? LoadingAnimation()
                    : nil
            }
        
    }
}

struct LoadingAnimation: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea()
            ProgressView()
                .controlSize(.large)
                .padding(50)
                .background(.background, in: RoundedRectangle(cornerRadius: 20))
        }
        
    }
}

extension View {
    
    /// Convience method which modifies a view with`LoadingViewModifier`.
    ///
    /// - Parameter isLoading: Loading state of the loader.
    /// - Returns: A modified view.
    public func loader(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}

#Preview {
    VStack {
        HStack {
            Spacer()
            Text("Example Loader")
            Spacer()
        }
        Spacer()
    }
    .loader(.constant(true))
}
