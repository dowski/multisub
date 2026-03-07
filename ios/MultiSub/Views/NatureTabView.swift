import SwiftUI

struct NatureTabView: View {
    @EnvironmentObject var vm: NatureTabViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Color card
                DataCard(title: "Random Color") {
                    if let color = vm.color {
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: color.hex))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(color.name)
                                    .font(.title2)
                                    .bold()
                                Text(color.hex)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .monospaced()
                            }
                        }
                    } else {
                        PlaceholderText()
                    }
                }

                // Animal card
                DataCard(title: "Random Animal") {
                    if let animal = vm.animal {
                        VStack(spacing: 4) {
                            Text(animal.emoji)
                                .font(.system(size: 48))
                            Text(animal.name)
                                .font(.title2)
                                .bold()
                            Text("\"\(animal.sound)\"")
                                .font(.body)
                                .italic()
                                .foregroundColor(.secondary)
                        }
                    } else {
                        PlaceholderText()
                    }
                }

                // Weather card
                DataCard(title: "Random Weather") {
                    if let weather = vm.weather {
                        VStack(spacing: 4) {
                            Text(weather.condition)
                                .font(.title2)
                                .bold()
                            HStack(spacing: 20) {
                                Label("\(weather.tempFInt)°F", systemImage: "thermometer")
                                Label("\(weather.humidityInt)%", systemImage: "humidity")
                            }
                            .font(.body)
                            .foregroundColor(.secondary)
                        }
                    } else {
                        PlaceholderText()
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Nature")
    }
}
