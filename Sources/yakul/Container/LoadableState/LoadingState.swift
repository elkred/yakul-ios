public enum LoadingState<T> {
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

public extension LoadingState {
    func map<U>(_ transform: (T) throws -> U) -> LoadingState<U> {
        switch self {
        case .loading:
            return .loading
        case .content(let value):
            do {
                return .content(try transform(value))
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
