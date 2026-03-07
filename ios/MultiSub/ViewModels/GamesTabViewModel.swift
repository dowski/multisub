import Foundation
import Combine
import ConvexMobile

final class GamesTabViewModel: ObservableObject {
    @Published var playingCard: PlayingCard?
    @Published var coordinate: Coordinate?
    @Published var score: Score?

    private let client = ConvexClientProvider.client

    init() {
        client.subscribe(to: "queries:getPlayingCards", yielding: [PlayingCard].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$playingCard)

        client.subscribe(to: "queries:getCoordinates", yielding: [Coordinate].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$coordinate)

        client.subscribe(to: "queries:getScores", yielding: [Score].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$score)
    }
}
