import SwiftUI

@available(iOS 17.0, *)

/// An image that you can magnify by pinching to zoom.
struct PinchZoomImage: View {
    
    // MARK: - Init
    
    var image: ImageResource
    
    // MARK: - Private State
    
    @GestureState private var zoom = 1.0
    
    // MARK: - Body
    
    var body: some View {
        Image(image)
            .resizable()
            .scaleEffect(zoom)
            .gesture(
                MagnifyGesture()
                    .updating($zoom) { value, gestureState, transaction in
                        gestureState = value.magnification
                    }
            )
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack {
        PinchZoomImage(image: .example)
            .scaledToFit()
    }
}
