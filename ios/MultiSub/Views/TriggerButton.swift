import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var offset: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    let width = geo.size.width
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .white.opacity(0.35), location: 0.4),
                            .init(color: .white.opacity(0.35), location: 0.6),
                            .init(color: .clear, location: 1),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: width * 0.6)
                    .offset(x: offset * width)
                }
            )
            .clipped()
            .onAppear {
                offset = -0.6
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                    offset = 1.0
                }
            }
    }
}

struct TriggerButton: View {
    @EnvironmentObject var headerVM: HeaderViewModel

    var body: some View {
        Button(action: {
            headerVM.triggerUpdates()
        }) {
            HStack {
                if headerVM.isTriggeringUpdate {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: headerVM.isActive ? "bolt.fill" : "bolt")
                }
                Text(buttonLabel)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(headerVM.isActive ? Color.green : Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .modifier(ShimmerWhenActive(isActive: headerVM.isActive || headerVM.isTriggeringUpdate))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .disabled(headerVM.isActive || headerVM.isTriggeringUpdate)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private var buttonLabel: String {
        if headerVM.isTriggeringUpdate {
            return "Starting..."
        } else if headerVM.isActive {
            return "Updates Running..."
        } else {
            return "Trigger Updates"
        }
    }
}

struct ShimmerWhenActive: ViewModifier {
    let isActive: Bool

    func body(content: Content) -> some View {
        if isActive {
            content.modifier(ShimmerModifier())
        } else {
            content
        }
    }
}
