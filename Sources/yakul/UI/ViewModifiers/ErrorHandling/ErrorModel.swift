import Foundation

/// Model used to parse and process errors of all types.
struct ErrorModel {
    
    // MARK: - Init
    
    /// Main Init
    ///
    /// - Parameter error: The error to be parsed.
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
    
    /// This can be used for edge error cases (i.e. If the error is localized, but there is a localized description available.)
    /// or it can be used to simply display custom messages in an error if you don't want to create a type.
    ///
    /// - Parameter customMessage: The message to be displayed in the error.
    init(customMessage: String) {
        self.title = "Error"
        self.message = customMessage
    }
    
    
    /// If the error is a localized error, we set the title and message based on properties of `LocalizedError`.
    ///
    /// - Parameter localizedError: The localized error to be parsed.
    private init(localizedError: LocalizedError) {
        self.title = localizedError.failureReason ?? "Error"
        self.message = localizedError.errorDescription ?? "Please try again."
    }
    
    // MARK: - Properties
    
    let title: String
    let message: String
    
    
    // MARK: - Helpers
    
    /// A single line error description.
    var description: String {
        return title.isEmpty
            ? message
            : "\(title)\n\(message)"
    }
}

/// Default error in rare cases.
/// **There should be none of these if we can help it!**
public struct UnknownError: LocalizedError {
    
    public init() { }
    
    public var failureReason: String? {
        return "Error"
    }
    
    public var errorDescription: String? {
        return "Please try again."
    }
}
