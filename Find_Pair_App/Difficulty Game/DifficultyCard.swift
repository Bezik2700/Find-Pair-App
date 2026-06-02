import SwiftUI

struct DifficultyCard: Identifiable {
    let id = UUID()
    let emoji: String
    let category: String
    var isFaceUp = false
    var isMatched = false
}
