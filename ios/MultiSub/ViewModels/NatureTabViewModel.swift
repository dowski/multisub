import Foundation
import Combine
import ConvexMobile

final class NatureTabViewModel: ObservableObject {
    @Published var color: ColorData?
    @Published var animal: Animal?
    @Published var weather: Weather?

    private let client = ConvexClientProvider.client

    init() {
        client.subscribe(to: "queries:getColors", yielding: [ColorData].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$color)

        client.subscribe(to: "queries:getAnimals", yielding: [Animal].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$animal)

        client.subscribe(to: "queries:getWeather", yielding: [Weather].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$weather)
    }
}
