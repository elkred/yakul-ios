import SwiftUI

@available(iOS 17.0, *)

/// A modifier so that you can magnify a view by pinching to zoom.
struct PinchZoomViewModifier: ViewModifier {
    
    // MARK: - Private State
    
    @GestureState private var zoom = 1.0

    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(zoom)
            .gesture(
                MagnifyGesture()
                    .updating($zoom) { value, gestureState, transaction in
                        gestureState = value.magnification
                    }
            )
    }
}

extension View {
    @available(iOS 17.0, *)
    func pinchToZoom() -> some View {
        modifier(PinchZoomViewModifier())
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack {
        Image(.example)
            .resizable()
            .scaledToFit()
            .pinchToZoom()
    }
}
