import SwiftUI

struct Level {
    let number: Int
    let pairs: Int
    let columns: Int
    let rows: Int
    let type: ContentType
    
    var totalCards: Int { pairs * 2 }
}
