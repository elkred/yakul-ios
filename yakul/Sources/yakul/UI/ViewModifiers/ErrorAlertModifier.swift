import SwiftUI

@available(iOS 15.0, *)
public struct ErrorAlertModifier: ViewModifier {
    @Binding var error: Error?
    
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
    
    private var errorModel: ErrorModel { ErrorModel(error) }
    
    public func body(content: Content) -> some View {
        content
            .alert(
                errorModel.title,
                isPresented: isPresented,
                actions: {
                    Button("Ok") {
                        //nop
                    }
                },
                message: {
                    Text(errorModel.message)
                }
            )
    }

    struct ErrorModel {
        let title: String
        let message: String
        
        var description: String {
            return title.isEmpty
                ? message
                : "\(title)\n\(message)"
        }
        
        init(_ error: Error?) {
            guard let error = error as? LocalizedError else {
                if let localizedDescription = error?.localizedDescription {
                    self.init(customMessage: localizedDescription)
                } else {
                    self.init(localizedError: UnknownError())
                }
                return
            }
        
            self.init(localizedError: error)
        }
        
        private init(localizedError: LocalizedError) {
            self.title = localizedError.failureReason ?? "Error"
            self.message = localizedError.errorDescription ?? "Please try again."
        }
        
        private init(customMessage: String) {
            self.title = "Error"
            self.message = customMessage
        }
    }

    struct UnknownError: Error, LocalizedError {
        var failureReason: String? {
            return "Error"
        }
        
        var errorDescription: String? {
            return "Please try again."
        }
    }
}

@available(iOS 15.0, *)
extension View {
    public func alert(_ error: Binding<Error?>) -> some View {
        modifier(ErrorAlertModifier(error: error))
    }
}

