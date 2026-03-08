import SwiftUI

struct GamesTabView: View {
    @StateObject private var vm = GamesTabViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Playing card
                DataCard(title: "Random Card") {
                    if let card = vm.playingCard {
                        VStack(spacing: 4) {
                            Text(card.display)
                                .font(.system(size: 48, weight: .bold, design: .serif))
                                .foregroundColor(
                                    (card.suit == "\u{2665}" || card.suit == "\u{2666}")
                                        ? .red : .primary
                                )
                            Text("\(card.rank) of \(suitName(card.suit))")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        PlaceholderText()
                    }
                }

                // Coordinates
                DataCard(title: "Random Location") {
                    if let coord = vm.coordinate {
                        VStack(spacing: 4) {
                            Text(coord.label)
                                .font(.title2)
                                .bold()
                            HStack(spacing: 16) {
                                Label(String(format: "%.3f", coord.lat), systemImage: "arrow.up.arrow.down")
                                Label(String(format: "%.3f", coord.lng), systemImage: "arrow.left.arrow.right")
                            }
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .monospaced()
                        }
                    } else {
                        PlaceholderText()
                    }
                }

                // Scores
                DataCard(title: "Random Score") {
                    if let score = vm.score {
                        VStack(spacing: 4) {
                            Text(score.sport)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .textCase(.uppercase)
                            HStack(spacing: 20) {
                                VStack {
                                    Text("HOME")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Text("\(score.homeInt)")
                                        .font(.system(size: 36, weight: .bold, design: .rounded))
                                }
                                Text("—")
                                    .font(.title)
                                    .foregroundColor(.secondary)
                                VStack {
                                    Text("AWAY")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Text("\(score.awayInt)")
                                        .font(.system(size: 36, weight: .bold, design: .rounded))
                                }
                            }
                        }
                    } else {
                        PlaceholderText()
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Games")
        .onAppear { vm.subscribe() }
        .onDisappear { vm.unsubscribe() }
    }

    private func suitName(_ suit: String) -> String {
        switch suit {
        case "\u{2660}": return "Spades"
        case "\u{2665}": return "Hearts"
        case "\u{2666}": return "Diamonds"
        case "\u{2663}": return "Clubs"
        default: return suit
        }
    }
}
