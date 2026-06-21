import SwiftUI

struct DifficultyGameData {
    static let levelCategories: [[(emoji: String, category: String)]] = [
        [
            ("🐨", "animals"), ("🐻", "animals"),
            ("🌸", "plants"), ("🌹", "plants")
        ],
        
        [
            ("🐶", "animals"), ("🐱", "animals"),
            ("🌺", "plants"), ("🌻", "plants"),
            ("🍎", "fruits"), ("🍊", "fruits")
        ],
        
        [
            ("🐼", "animals"), ("🦊", "animals"),
            ("🍋", "fruits"), ("🍇", "fruits"),
            ("⚽️", "sports"), ("🏀", "sports"),
            ("🎸", "music"), ("🎹", "music")
        ],
        
        [
            ("🐸", "animals"), ("🐰", "animals"),
            ("🍓", "fruits"), ("🍑", "fruits"),
            ("🎾", "sports"), ("🏈", "sports"),
            ("🥁", "music"), ("🎺", "music"),
            ("🌈", "nature"), ("⭐️", "nature")
        ],
        
        [
            ("🐯", "animals"), ("🐨", "animals"),
            ("🍒", "fruits"), ("🥝", "fruits"),
            ("🎱", "sports"), ("🏓", "sports"),
            ("🎷", "music"), ("🎻", "music"),
            ("🌙", "nature"), ("☀️", "nature"),
            ("🍕", "food"), ("🍔", "food")
        ]
    ]
    
    static let categoryNames: [String: String] = [
        "animals": "🐾 Животные",
        "plants": "🌿 Растения",
        "fruits": "🍎 Фрукты",
        "sports": "⚽️ Спорт",
        "music": "🎵 Музыка",
        "nature": "🌈 Природа",
        "food": "🍕 Еда"
    ]
}
