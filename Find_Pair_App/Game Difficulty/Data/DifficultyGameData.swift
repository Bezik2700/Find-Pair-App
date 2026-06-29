import SwiftUI

struct DifficultyGameData {
    
    static let animals: [(emoji: String, category: String)] = [
        ("🐨", "animals"), ("🐻", "animals"), ("🐶", "animals"), ("🐱", "animals"),
        ("🐼", "animals"), ("🦊", "animals"), ("🐸", "animals"), ("🐰", "animals"),
        ("🐯", "animals"), ("🐮", "animals")
    ]
    
    static let plants: [(emoji: String, category: String)] = [
        ("🌸", "plants"), ("🌹", "plants"), ("🌺", "plants"), ("🌻", "plants"),
        ("🌷", "plants"), ("🌼", "plants"), ("💐", "plants"), ("🪷", "plants"),
        ("🌵", "plants"), ("🍀", "plants")
    ]
    
    static let fruits: [(emoji: String, category: String)] = [
        ("🍎", "fruits"), ("🍊", "fruits"), ("🍋", "fruits"), ("🍇", "fruits"),
        ("🍓", "fruits"), ("🍑", "fruits"), ("🍒", "fruits"), ("🥝", "fruits"),
        ("🍌", "fruits"), ("🍐", "fruits")
    ]
    
    static let sports: [(emoji: String, category: String)] = [
        ("⚽️", "sports"), ("🏀", "sports"), ("🎾", "sports"), ("🏈", "sports"),
        ("🎱", "sports"), ("🏓", "sports"), ("⚾️", "sports"), ("🏐", "sports"),
        ("🏒", "sports"), ("🥊", "sports")
    ]
    
    static let music: [(emoji: String, category: String)] = [
        ("🎸", "music"), ("🎹", "music"), ("🥁", "music"), ("🎺", "music"),
        ("🎷", "music"), ("🎻", "music"), ("🪕", "music"), ("🎵", "music"),
        ("🎤", "music"), ("🎧", "music")
    ]
    
    static let nature: [(emoji: String, category: String)] = [
        ("🌈", "nature"), ("⭐️", "nature"), ("🌙", "nature"), ("☀️", "nature"),
        ("⚡️", "nature"), ("❄️", "nature"), ("🌊", "nature"), ("🔥", "nature"),
        ("🌪️", "nature"), ("🌍", "nature")
    ]
    
    static let food: [(emoji: String, category: String)] = [
        ("🍕", "food"), ("🍔", "food"), ("🌮", "food"), ("🍩", "food"),
        ("🎂", "food"), ("🍪", "food"), ("🧁", "food"), ("🍿", "food"),
        ("🍦", "food"), ("🧀", "food")
    ]
    
    static let levelCategories: [(items: [(emoji: String, category: String)], matchCount: Int)] = [
   
        (
            items: Array(animals.prefix(2)) + Array(plants.prefix(2)),
            matchCount: 2
        ),
        
        (
            items: Array(animals.shuffled().prefix(2)) + Array(plants.shuffled().prefix(2)) + Array(fruits.shuffled().prefix(2)),
            matchCount: 2
        ),
        
        (
            items: Array(animals.shuffled().prefix(3)) + Array(fruits.shuffled().prefix(3)),
            matchCount: 3
        ),
        
        (
            items: Array(animals.shuffled().prefix(3)) + Array(sports.shuffled().prefix(3)) + Array(music.shuffled().prefix(3)),
            matchCount: 3
        ),
        
        (
            items: Array(fruits.shuffled().prefix(4)) + Array(sports.shuffled().prefix(4)),
            matchCount: 4
        ),
        
        (
            items: Array(animals.shuffled().prefix(4)) + Array(music.shuffled().prefix(4)) + Array(food.shuffled().prefix(4)),
            matchCount: 4
        ),
        
        (
            items: Array(animals.shuffled().prefix(5)) + Array(fruits.shuffled().prefix(5)),
            matchCount: 5
        ),
        
        (
            items: Array(sports.shuffled().prefix(5)) + Array(music.shuffled().prefix(5)),
            matchCount: 5
        )
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
