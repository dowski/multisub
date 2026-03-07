import Foundation
import Combine
import ConvexMobile

final class GamesTabViewModel: ObservableObject {
    @Published var playingCard: PlayingCard?
    @Published var coordinate: Coordinate?
    @Published var score: Score?

    private let client = ConvexClientProvider.client
    private var cancellables = Set<AnyCancellable>()

    func subscribe() {
        guard cancellables.isEmpty else { return }

        client.subscribe(to: "queries:getPlayingCards", yielding: [PlayingCard].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.playingCard = $0 }
            .store(in: &cancellables)

        client.subscribe(to: "queries:getCoordinates", yielding: [Coordinate].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.coordinate = $0 }
            .store(in: &cancellables)

        client.subscribe(to: "queries:getScores", yielding: [Score].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.score = $0 }
            .store(in: &cancellables)
    }

    func unsubscribe() {
        cancellables.removeAll()
    }
}
