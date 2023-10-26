import SwiftUI

public struct LoadingViewModifier: ViewModifier {
    
    // MARK: - Init
    
    @Binding public var isLoading: Bool
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                isLoading
                    ? ProgressView()
                    : nil
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
        Text("Example Loader")
        Spacer()
    }
    .loader(.constant(true))
    .progressViewStyle(PrimaryCircularProgressViewStyle())
}
