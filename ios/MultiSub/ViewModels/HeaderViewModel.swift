import Foundation
import Combine
import ConvexMobile

final class HeaderViewModel: ObservableObject {
    @Published var diceRoll: DiceRoll?
    @Published var updateStatus: UpdateStatus?
    @Published var isTriggeringUpdate = false

    private let client = ConvexClientProvider.client

    init() {
        client.subscribe(to: "queries:getDiceRolls", yielding: [DiceRoll].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$diceRoll)

        client.subscribe(to: "queries:getUpdateStatus", yielding: [UpdateStatus].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$updateStatus)
    }

    var isActive: Bool {
        updateStatus?.active ?? false
    }

    func triggerUpdates() {
        guard !isTriggeringUpdate else { return }
        isTriggeringUpdate = true

        Task {
            do {
                try await client.mutation("mutations:triggerUpdates")
            } catch {
                print("Failed to trigger updates: \(error)")
            }
            await MainActor.run {
                isTriggeringUpdate = false
            }
        }
    }
}
