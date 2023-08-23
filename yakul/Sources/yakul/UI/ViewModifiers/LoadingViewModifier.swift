import SwiftUI

@available(iOS 15.0, *)
public struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                isLoading
                    ? ProgressView()
                    : nil
            }
    }
}

@available(iOS 15.0, *)
extension View {
    public func loader(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
