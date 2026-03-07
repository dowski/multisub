import Foundation
import Combine
import ConvexMobile

final class VibesTabViewModel: ObservableObject {
    @Published var mood: Mood?
    @Published var word: Word?
    @Published var planet: Planet?

    private let client = ConvexClientProvider.client
    private var cancellables = Set<AnyCancellable>()

    func subscribe() {
        guard cancellables.isEmpty else { return }

        client.subscribe(to: "queries:getMoods", yielding: [Mood].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.mood = $0 }
            .store(in: &cancellables)

        client.subscribe(to: "queries:getWords", yielding: [Word].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.word = $0 }
            .store(in: &cancellables)

        client.subscribe(to: "queries:getPlanets", yielding: [Planet].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.planet = $0 }
            .store(in: &cancellables)
    }

    func unsubscribe() {
        cancellables.removeAll()
    }
}
