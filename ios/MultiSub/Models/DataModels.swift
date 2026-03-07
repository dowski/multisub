import Foundation
import ConvexMobile

// Convex number → @ConvexFloat (Double)
// Convex float64 → @ConvexFloat (Double)
// Convex boolean → Bool
// Convex string → String
// Convex Id → String

struct DiceRoll: Decodable, Identifiable {
    let _id: String
    @ConvexFloat var die1: Double
    @ConvexFloat var die2: Double
    @ConvexFloat var total: Double

    var id: String { _id }
    var die1Int: Int { Int(die1) }
    var die2Int: Int { Int(die2) }
    var totalInt: Int { Int(total) }
}

struct ColorData: Decodable, Identifiable {
    let _id: String
    let hex: String
    let name: String

    var id: String { _id }
}

struct Animal: Decodable, Identifiable {
    let _id: String
    let name: String
    let emoji: String
    let sound: String

    var id: String { _id }
}

struct Weather: Decodable, Identifiable {
    let _id: String
    let condition: String
    @ConvexFloat var tempF: Double
    @ConvexFloat var humidity: Double

    var id: String { _id }
    var tempFInt: Int { Int(tempF) }
    var humidityInt: Int { Int(humidity) }
}

struct PlayingCard: Decodable, Identifiable {
    let _id: String
    let suit: String
    let rank: String
    let display: String

    var id: String { _id }
}

struct Coordinate: Decodable, Identifiable {
    let _id: String
    @ConvexFloat var lat: Double
    @ConvexFloat var lng: Double
    let label: String

    var id: String { _id }
}

struct Score: Decodable, Identifiable {
    let _id: String
    @ConvexFloat var home: Double
    @ConvexFloat var away: Double
    let sport: String

    var id: String { _id }
    var homeInt: Int { Int(home) }
    var awayInt: Int { Int(away) }
}

struct Mood: Decodable, Identifiable {
    let _id: String
    let mood: String
    let emoji: String
    @ConvexFloat var intensity: Double

    var id: String { _id }
    var intensityInt: Int { Int(intensity) }
}

struct Word: Decodable, Identifiable {
    let _id: String
    let word: String
    let language: String
    @ConvexFloat var length: Double

    var id: String { _id }
    var lengthInt: Int { Int(length) }
}

struct Planet: Decodable, Identifiable {
    let _id: String
    let name: String
    @ConvexFloat var distanceAU: Double
    @ConvexFloat var moons: Double

    var id: String { _id }
    var moonsInt: Int { Int(moons) }
}

struct UpdateStatus: Decodable, Identifiable {
    let _id: String
    let active: Bool
    @ConvexFloat var startedAt: Double
    @ConvexFloat var updatesRemaining: Double

    var id: String { _id }
}
