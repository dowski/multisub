import SwiftUI

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
        }
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
