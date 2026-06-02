import SwiftUI

struct GameData {
    static let emojis = [
        "🌸", "🌺", "🌻", "🌹", "🌷", "🌼", "💐", "🪷",
        "🍎", "🍊", "🍋", "🍇", "🍓", "🍑", "🍒", "🥝",
        "🎸", "🎹", "🥁", "🎺", "🎷", "🎻", "🪕", "🎵",
        "⚽️", "🏀", "🎾", "🏈", "⚾️", "🏐", "🎱", "🏓",
        "🐶", "🐱", "🐼", "🐨", "🐸", "🦊", "🐰", "🐯",
        "🍕", "🍔", "🌮", "🍩", "🎂", "🍪", "🧁", "🍿",
        "🚗", "✈️", "🚀", "⛵️", "🚲", "🚁", "🛴", "🏍️",
        "🌈", "⭐️", "🌙", "☀️", "⚡️", "❄️", "🌊", "🔥"
    ]
    
    static let numbers: [String] = {(1...100).map { "\($0)" }}()
    
    static let colors: [(name: String, color: Color)] = [

        ("Red", .red),
        ("Dark Red", Color(red: 0.55, green: 0.0, blue: 0.0)),
        ("Crimson", Color(red: 0.86, green: 0.08, blue: 0.24)),
        ("Burgundy", Color(red: 0.5, green: 0.0, blue: 0.13)),
        ("Scarlet", Color(red: 1.0, green: 0.14, blue: 0.0)),
        ("Brick", Color(red: 0.7, green: 0.13, blue: 0.13)),
        
        ("Blue", .blue),
        ("Dark Blue", Color(red: 0.0, green: 0.0, blue: 0.55)),
        ("Light Blue", .cyan),
        ("Sky Blue", Color(red: 0.53, green: 0.81, blue: 0.98)),
        ("Azure", Color(red: 0.0, green: 0.5, blue: 1.0)),
        ("Indigo", Color(red: 0.29, green: 0.0, blue: 0.51)),
        ("Turquoise", Color(red: 0.25, green: 0.88, blue: 0.82)),
        ("Cornflower", Color(red: 0.39, green: 0.58, blue: 0.93)),
        
        ("Green", .green),
        ("Dark Green", Color(red: 0.0, green: 0.39, blue: 0.0)),
        ("Light Green", Color(red: 0.6, green: 0.98, blue: 0.6)),
        ("Emerald", Color(red: 0.31, green: 0.78, blue: 0.47)),
        ("Mint", Color(red: 0.6, green: 0.9, blue: 0.75)),
        ("Olive", Color(red: 0.42, green: 0.56, blue: 0.14)),
        ("Lime", Color(red: 0.75, green: 1.0, blue: 0.0)),
        ("Forest", Color(red: 0.13, green: 0.55, blue: 0.13)),
        
        ("Yellow", .yellow),
        ("Orange", .orange),
        ("Gold", Color(red: 1.0, green: 0.84, blue: 0.0)),
        ("Amber", Color(red: 1.0, green: 0.75, blue: 0.0)),
        ("Peach", Color(red: 1.0, green: 0.85, blue: 0.73)),
        ("Apricot", Color(red: 0.98, green: 0.67, blue: 0.42)),
        ("Tangerine", Color(red: 0.96, green: 0.53, blue: 0.18)),
        ("Canary", Color(red: 0.99, green: 0.98, blue: 0.39)),
        
        ("Purple", .purple),
        ("Pink", .pink),
        ("Magenta", Color(red: 0.5, green: 0.0, blue: 0.5)),
        ("Lilac", Color(red: 0.78, green: 0.64, blue: 0.78)),
        ("Lavender", Color(red: 0.9, green: 0.9, blue: 0.98)),
        ("Fuchsia", Color(red: 1.0, green: 0.0, blue: 1.0)),
        ("Orchid", Color(red: 0.85, green: 0.7, blue: 0.85)),
        ("Plum", Color(red: 0.87, green: 0.63, blue: 0.87)),
        ("Hot Pink", Color(red: 1.0, green: 0.0, blue: 0.5)),
        
        ("White", .white),
        ("Gray", .gray),
        ("Black", .black),
        ("Brown", .brown),
        ("Beige", Color(red: 0.96, green: 0.96, blue: 0.86)),
        ("Cream", Color(red: 1.0, green: 0.99, blue: 0.82)),
        ("Sand", Color(red: 0.94, green: 0.87, blue: 0.64)),
        ("Chocolate", Color(red: 0.55, green: 0.27, blue: 0.07)),
        ("Chestnut", Color(red: 0.59, green: 0.29, blue: 0.0)),
        ("Coral", Color(red: 1.0, green: 0.5, blue: 0.31)),
        ("Cyan", Color(red: 0.0, green: 1.0, blue: 1.0))
    ]
    
    static func getLevelConfig(for levelNumber: Int) -> (pairs: Int, columns: Int, rows: Int) {
        switch levelNumber {
        case 1...2:  return (2, 2, 2)
        case 3...4:  return (4, 3, 3)
        case 5...6:  return (6, 3, 4)
        case 7...8:  return (8, 4, 4)
        case 9...10: return (10, 4, 5)
        case 11...12: return (12, 4, 6)
        case 13...14: return (15, 5, 6)
        case 15...16: return (17, 5, 7)
        case 17...18: return (21, 6, 7)
        default:      return (24, 6, 8)
        }
    }
    
    static func getClickLimit(for levelNumber: Int) -> Int {
        guard levelNumber % 4 == 0 else { return 0 }
        let limitLevel = levelNumber / 4
        switch limitLevel {
        case 1: return 15
        case 2: return 25
        case 3: return 35
        case 4: return 45
        case 5: return 55
        default: return limitLevel * 10
        }
    }
    
    static func getTimeLimit(for levelNumber: Int) -> Int {
        guard levelNumber % 5 == 0 else { return 0 }
        
        let limitLevel = levelNumber / 5
        switch limitLevel {
        case 1: return 30
        case 2: return 45
        case 3: return 60
        case 4: return 75
        case 5: return 90
        default: return limitLevel * 15 + 15
        }
    }
}
