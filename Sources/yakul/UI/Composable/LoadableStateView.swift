import SwiftUI

@available(iOS 15.0, *)
public struct LoadableStateView<Content: View, T: Collection>: View {
    public let state: LoadableViewState<T>
    public let content: (T) -> Content
    public let retry: () -> Void

    public var body: some View {
        switch state {
        case .loading:
            VStack {
                Spacer()
                ProgressView().progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
        case .content(let value):
            if value.isEmpty {
                emptyContent
            } else {
                content(value)
            }
        case .failure(let error):
            VStack {
                Spacer()
                Text(error.localizedDescription)
                    .font(.title)
                    .fontWeight(.semibold)
                Button("Retry?", action: retry)
                    .buttonStyle(.borderedProminent)
                    .font(.title2)
                Spacer()
            }
        }
    }
    
    private var emptyContent: some View {
        VStack {
            Spacer()
            Text("No Results")
                .font(.title)
                .fontWeight(.semibold)
            Button("Retry?", action: retry)
                .buttonStyle(.borderedProminent)
                .font(.title2)
            Spacer()
        }
    }
}

public enum LoadableViewState<T> {
    case loading
    case content(T)
    case failure(Error)
    
    public var value: T? {
        guard case .content(let t) = self else {
            return nil
        }

        return t
    }
}
