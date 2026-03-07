import Foundation
import Combine
import ConvexMobile

final class NatureTabViewModel: ObservableObject {
    @Published var color: ColorData?
    @Published var animal: Animal?
    @Published var weather: Weather?

    private let client = ConvexClientProvider.client
    private var cancellables = Set<AnyCancellable>()

    func subscribe() {
        guard cancellables.isEmpty else { return }

        client.subscribe(to: "queries:getColors", yielding: [ColorData].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.color = $0 }
            .store(in: &cancellables)

        client.subscribe(to: "queries:getAnimals", yielding: [Animal].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.animal = $0 }
            .store(in: &cancellables)

        client.subscribe(to: "queries:getWeather", yielding: [Weather].self)
            .map(\.first)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.weather = $0 }
            .store(in: &cancellables)
    }

    func unsubscribe() {
        cancellables.removeAll()
    }
}
