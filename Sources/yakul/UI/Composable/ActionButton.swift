import SwiftUI

/// Async throwing button that allows you to throw errors down to the view, and also handle concurrency.
public struct ActionButton<ButtonLabel: View>: View {
    
    // MARK: - Standard Init
    
    /// The role of this action. `nil` if no specific role.
    private var role: ButtonRole? = nil
    
    /// An async throwing action closure to send the action via.
    private var action: () async throws -> Void
    
    /// A closure allowing the button to be configured based on the view past into it.
    @ViewBuilder private var label: () -> ButtonLabel
    
    /// Default init to allow any view to be passed in.
    ///
    /// - Parameters:
    ///   - role: The role of this action. `nil` if no specific role.
    ///   - action: An async throwing action closure to send the action via.
    ///   - label: The view which fills the button label.
    public init(
        role: ButtonRole? = nil,
        action: @escaping () async throws -> Void,
        label: @escaping () -> ButtonLabel
    ) {
        self.label = label
        self.role = role
        self.action = action
    }
    
    // MARK: - Private State
    
    /// Whether an action is currently being performed or not.
    @State private var isPerformingTask = false
    
    /// The error state of this view.
    @State private var error: Error?
    
    // MARK: - Body

    public var body: some View {
        Button(role: role) {
            Task {
                isPerformingTask = true
                defer { isPerformingTask = false }
                do {
                    try await action()
                } catch let error {
                    self.error = error
                }
            }
        } label: {
            ZStack {
                if isPerformingTask {
                    ProgressView()
                }
                label()
                    .frame(maxWidth: .infinity)
                    .opacity(isPerformingTask ? 0 : 1)
            }
            .padding(.vertical)
        }
        .disabled(isPerformingTask)
        .alert($error)
    }
}

// MARK: - Convenience Inits

extension ActionButton where ButtonLabel == Text {
    
    /// Convenience init for a text only `ActionButton`.
    ///
    /// - Parameters:
    ///   - title: The title of this button.
    ///   - role: The role of this action. `nil` if no specific role.
    ///   - action: An async throwing action closure to send the action via.
    public init(
        _ title: String,
        role: ButtonRole? = nil,
        action: @escaping () async throws -> Void
    ) {
        self.label = { Text(title) }
        self.role = role
        self.action = action
    }
}

extension ActionButton where ButtonLabel == Label<Text, Image> {
    
    /// Convenience init for an `ActionButton` with text and a system image.
    ///
    /// - Parameters:
    ///   - title: The title of this button.
    ///   - systemImage: A system image name corresponding to an `SF Symbols` asset.
    ///   - role: The role of this action. `nil` if no specific role.
    ///   - action: An async throwing action closure to send the action via.
    public init(
        _ title: String,
        systemImage: String,
        role: ButtonRole? = nil,
        action: @escaping () async throws -> Void
    ) {
        self.label = { Label(title, systemImage: systemImage) }
        self.role = role
        self.action = action
    }
}

#Preview {
    VStack {
        ActionButton("Title Only") {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        }
        .buttonStyle(.bordered)
        
        ActionButton("Title And Image", systemImage: "speaker.wave.3") {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        }
        .buttonStyle(.borderedProminent)
        
        ActionButton {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "speaker.wave.3")
                    Image(systemName: "speaker.wave.2")
                    Spacer()
                    Text("Custom Button")
                        .foregroundColor(.red)
                }
                
                Text("Lorem Ipsum, etc.")
                    .foregroundColor(.green)
            }
        }
        .buttonStyle(.bordered)
        
        ActionButton("Failing Action", systemImage: "xmark") {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            throw UnknownError()
        }
        .buttonStyle(.borderedProminent)
        
        ActionButton("Destructive Action", role: .destructive) {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        }
        .buttonStyle(.borderedProminent)
        
        ActionButton("Cancel Action", role: .cancel) {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        }
        .buttonStyle(.borderedProminent)
    }
    .padding()
}
