import Foundation
import Combine
import ConvexMobile

final class VibesTabViewModel: ObservableObject {
    @Published var mood: Mood?
    @Published var word: Word?
    @Published var planet: Planet?

    private let client = ConvexClientProvider.client

    init() {
        client.subscribe(to: "queries:getMoods", yielding: [Mood].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$mood)

        client.subscribe(to: "queries:getWords", yielding: [Word].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$word)

        client.subscribe(to: "queries:getPlanets", yielding: [Planet].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$planet)
    }
}
