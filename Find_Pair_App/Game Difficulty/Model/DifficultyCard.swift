import SwiftUI

struct DifficultyCard: Identifiable {
    let id = UUID()
    let imageName: String
    let pairID: String
    var isFaceUp = false
    var isMatched = false
}
