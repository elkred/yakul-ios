import SwiftUI

public struct ErrorAlertViewModifier: ViewModifier {
    
    // MARK: - Init
    
    /// The error to be presented in the alert.
    @Binding var error: Error?
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .alert(
                errorModel.title,
                isPresented: isPresented,
                actions: {
                    Button("Ok") {}
                },
                message: {
                    Text(errorModel.message)
                }
            )
    }
    
    // MARK: - Helpers
    
    /// True if there is an error. False if an error is nil.
    /// If setting to false, sets the error to nil.
    private var isPresented: Binding<Bool> {
        Binding(
            get: {
                error != nil
            },
            set: {
                if $0 == false { error = nil }
            }
        )
    }
    
    /// The model making the error readable.
    private var errorModel: ErrorModel { ErrorModel(error) }
}

extension View {
    
    /// Convience method which modifies a view with`ErrorAlertModifier`.
    ///
    /// - Parameter error: The error to be presented in the alert.
    /// - Returns: A modified view.
    public func alert(_ error: Binding<Error?>) -> some View {
        modifier(ErrorAlertViewModifier(error: error))
    }
}

#Preview {
    return AlertPreview()
    
    /// Required to make preview interactive.
    struct AlertPreview: View {
        @State var error: Error?
        var body: some View {
            Button("Trigger Error") {
                error = UnknownError()
            }
            .alert($error)
        }
    }
}
