import SwiftUI

/// Async throwing button that allows you to throw errors down to the view, and also handle concurrency.
public struct ActionButton<ButtonLabel: View>: View {
    
    // MARK: - Standard Init
    
    /// The role of this action. `nil` if no specific role.
    public var role: ButtonRole? = nil
    
    /// An async throwing action closure to send the action via.
    public var action: () async throws -> Void
    
    /// A closure allowing the button to be configured based on the view past into it.
    @ViewBuilder public var label: () -> ButtonLabel
    
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
        .font(.headline)
        .disabled(isPerformingTask)
        .alert($error)
    }
}

// Convenience Inits

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
    ///   - systemImageName: A system image name corresponding to an `SF Symbols` asset.
    ///   - role: The role of this action. `nil` if no specific role.
    ///   - action: An async throwing action closure to send the action via.
    public init(
        _ title: String,
        systemImageName: String,
        role: ButtonRole? = nil,
        action: @escaping () async throws -> Void
    ) {
        self.label = { Label(title, systemImage: systemImageName) }
        self.role = role
        self.action = action
    }
}

#Preview {
    VStack {
        ActionButton("Title Only") {
            try await Task.sleep(for: .seconds(2))
        }
        .buttonStyle(.bordered)
        
        ActionButton("Title And Image", systemImageName: "speaker.wave.3") {
            try await Task.sleep(for: .seconds(2))
        }
        .buttonStyle(.borderedProminent)
        
        ActionButton {
            try await Task.sleep(for: .seconds(2))
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
        
        ActionButton("Failing Action", systemImageName: "xmark") {
            try await Task.sleep(for: .seconds(1))
            throw UnknownError()
        }
        .buttonStyle(.borderedProminent)
        
        ActionButton("Destructive Action", role: .destructive) {
            try await Task.sleep(for: .seconds(2))
        }
        .buttonStyle(.borderedProminent)
        
        ActionButton("Cancel Action", role: .cancel) {
            try await Task.sleep(for: .seconds(2))
        }
        .buttonStyle(.borderedProminent)
    }
    .padding()
}
