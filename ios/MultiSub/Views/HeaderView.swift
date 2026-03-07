import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var headerVM: HeaderViewModel

    var body: some View {
        VStack(spacing: 8) {
            if let roll = headerVM.diceRoll {
                HStack(spacing: 16) {
                    DieView(value: roll.die1Int)
                    DieView(value: roll.die2Int)
                }

                Text("Total: \(roll.totalInt)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            } else {
                Text("No dice data yet")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }

            if headerVM.isActive {
                HStack(spacing: 6) {
                    ProgressView()
                        .scaleEffect(0.7)
                    Text("Updating...")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
    }
}

struct DieView: View {
    let value: Int

    var body: some View {
        Text(dieFace(value))
            .font(.system(size: 48))
    }

    private func dieFace(_ n: Int) -> String {
        switch n {
        case 1: return "\u{2680}"
        case 2: return "\u{2681}"
        case 3: return "\u{2682}"
        case 4: return "\u{2683}"
        case 5: return "\u{2684}"
        case 6: return "\u{2685}"
        default: return "?"
        }
    }
}
