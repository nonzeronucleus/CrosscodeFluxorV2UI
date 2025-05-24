import SwiftUI

struct ZoomableScrollView<Content: View>: View   {
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var anchor: UnitPoint = .center

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            content
                .scaleEffect(scale, anchor: anchor)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let newScale = lastScale * value
                            let clampedScale = min(max(newScale, 1.0), 3.0)

                            // Calculate the scaled content size
                            let scaledWidth = geometry.size.width * clampedScale
                            let scaledHeight = geometry.size.height * clampedScale

                            // Compute new max offset based on updated scale
                            let maxOffsetX = (scaledWidth - geometry.size.width) / 2
                            let maxOffsetY = (scaledHeight - geometry.size.height) / 2

                            // Adjust the offset so it stays within bounds while scaling
                            let clampedOffsetX = max(-maxOffsetX, min(offset.width, maxOffsetX))
                            let clampedOffsetY = max(-maxOffsetY, min(offset.height, maxOffsetY))

                            scale = clampedScale
                            offset = CGSize(width: clampedOffsetX, height: clampedOffsetY)
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                )
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            let scaledWidth = geometry.size.width * scale
                            let scaledHeight = geometry.size.height * scale

                            let maxOffsetX = (scaledWidth - geometry.size.width) / 2
                            let maxOffsetY = (scaledHeight - geometry.size.height) / 2

                            let newOffsetX = lastOffset.width + value.translation.width
                            let newOffsetY = lastOffset.height + value.translation.height

                            offset = CGSize(
                                width: max(-maxOffsetX, min(newOffsetX, maxOffsetX)),
                                height: max(-maxOffsetY, min(newOffsetY, maxOffsetY))
                            )
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                .animation(.easeInOut(duration: 0.1), value: scale)
        }
    }
}


// Example Usage:
struct ScrollableContentView: View {
    var body: some View {
        ZoomableScrollView {
            Image(systemName: "star.fill") // Example content
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .background(Color.yellow.opacity(0.3))
        }
        .frame(width: 300, height: 300)
        .border(Color.gray)
    }
}
