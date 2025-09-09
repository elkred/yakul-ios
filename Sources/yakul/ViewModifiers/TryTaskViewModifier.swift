import SwiftUI

public struct TryTaskViewModifier: ViewModifier {
    
    var task: () async throws -> Void
    
    // MARK: - State
    
    @State private var error: Error?
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .alert($error)
            .task {
                do {
                    try await task()
                } catch { self.error = error }
            }
        
    }
}

extension View {
    
    ///
    /// Performs an asynchronous throwing task and automatically handles any errors by displaying them in an alert.
    ///
    /// Use this modifier when you want to perform an asynchronous task that might throw an error,
    /// and you want those errors to be automatically presented to the user in an alert dialog.
    ///
    /// Example:
    /// ```swift
    /// struct MyView: View {
    ///     var body: some View {
    ///         Text("Hello, World!")
    ///             .tryTask {
    ///                 // Your async throwing task here
    ///             }
    ///     }
    /// }
    /// ```
    /// - Parameter task: The task to try and await.
    /// - Returns: A modified view which handles and shows an alert of a async throwing function.
    public func tryTask(_ task: @escaping () async throws -> Void) -> some View {
        modifier(TryTaskViewModifier(task: task))
    }
}

#Preview {
    VStack {
        Text("Example View")
        Spacer()
    }
    .tryTask {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
    }
}
