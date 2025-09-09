import Foundation
import SwiftUI

/// A view which takes in a loading state, and produces state depedent UI. (i.e. `loading`, `content`, or `failure`).
public struct LoadableStateView<Content: View, T>: View {
    
    // MARK: - Init

    private let state: LoadingState<T>
    private let emptyContentTitle: String
    private let retryActionTitle: String
    @ViewBuilder private let content: (T) -> Content
    private let retry: () -> Void
    
    public init(
        state: LoadingState<T>,
        emptyContentTitle: String = "No Results",
        retryActionTitle: String = "Retry?",
        @ViewBuilder content: @escaping (T) -> Content,
        retry: @escaping () -> Void
    ) {
        self.state = state
        self.emptyContentTitle = emptyContentTitle
        self.retryActionTitle = retryActionTitle
        self.content = content
        self.retry = retry
    }
    
    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            switch state {
            case .loading: loadingView
            case .content(let value): content(value)
            case .failure(let error): errorView(.init(error))
            }
        }
    }
    
    // MARK: - Helper Views
    
    @ViewBuilder
    private var loadingView: some View {
        Spacer()
        ProgressView()
            .controlSize(.large)
        Spacer()
    }
    
    private func errorView(_ error: ErrorModel) -> some View {
        VStack(spacing: 15) {
            Spacer()
            VStack {
                Text(error.title)
                    .font(.headline)
                Text(error.message)
                    .font(.subheadline)
            }
            
            Button(retryActionTitle, action: retry)
                .buttonStyle(.borderedProminent)
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    LoadableStateView(state: .failure(UnknownError())) {
        Text("Wohoo")
    } retry: {
        // nop
    }
}
