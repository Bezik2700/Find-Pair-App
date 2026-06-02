import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let type: ContentType
    let content: String
    var isFaceUp = false
    var isMatched = false
}
