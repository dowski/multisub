import SwiftUI

struct VibesTabView: View {
    @EnvironmentObject var vm: VibesTabViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Mood
                DataCard(title: "Random Mood") {
                    if let mood = vm.mood {
                        VStack(spacing: 4) {
                            Text(mood.emoji)
                                .font(.system(size: 48))
                            Text(mood.mood)
                                .font(.title2)
                                .bold()
                            IntensityBar(value: mood.intensityInt, max: 10)
                        }
                    } else {
                        PlaceholderText()
                    }
                }

                // Word
                DataCard(title: "Random Word") {
                    if let word = vm.word {
                        VStack(spacing: 4) {
                            Text(word.word)
                                .font(.title)
                                .bold()
                                .italic()
                            Text(word.language)
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text("\(word.lengthInt) letters")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        PlaceholderText()
                    }
                }

                // Planet
                DataCard(title: "Random Planet") {
                    if let planet = vm.planet {
                        VStack(spacing: 4) {
                            Text(planet.name)
                                .font(.title2)
                                .bold()
                            HStack(spacing: 16) {
                                Label(
                                    String(format: "%.2f AU", planet.distanceAU),
                                    systemImage: "arrow.left.and.right"
                                )
                                Label(
                                    "\(planet.moonsInt) moon\(planet.moonsInt == 1 ? "" : "s")",
                                    systemImage: "moon.fill"
                                )
                            }
                            .font(.caption)
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
        .navigationTitle("Vibes")
        .onAppear { vm.subscribe() }
        .onDisappear { vm.unsubscribe() }
    }
}

struct IntensityBar: View {
    let value: Int
    let max: Int

    var body: some View {
        HStack(spacing: 3) {
            ForEach(1...max, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(i <= value ? Color.orange : Color.orange.opacity(0.2))
                    .frame(height: 8)
            }
        }
        .frame(width: 120)
    }
}
