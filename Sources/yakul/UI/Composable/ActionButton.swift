import SwiftUI

@available(iOS 15.0, *)
public struct ActionButton<Label: View>: View {
    var action: () async throws -> Void
    @ViewBuilder var label: () -> Label

    @State private var isPerformingTask = false
    @State private var error: Error?

    public var body: some View {
        Button(
            action: {
                Task {
                    isPerformingTask = true
                    defer { isPerformingTask = false }
                    do {
                        try await action()
                    } catch let error {
                        self.error = error
                    }
                }
            },
            label: {
                if isPerformingTask {
                    HStack {
                        Spacer()
                        ProgressView().tint(.primary)
                        Spacer()
                    }
                } else {
                    label()
                }
            }
        )
        .disabled(isPerformingTask)
        .alert($error)
    }
}

// Text init
@available(iOS 15.0, *)
extension ActionButton where Label == Text {
    init(
        _ title: String,
        action: @escaping () async -> Void
    ) {
        self.label = { Text(title) }
        self.action = action
    }
}
