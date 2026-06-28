import SwiftUI

// DifficultyGameData.swift
struct DifficultyGameData {
    
    // MARK: - Группы эмодзи
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
    
    // MARK: - Уровни: (items, matchCount)
    // matchCount = сколько одинаковых нужно найти (2, 3, 4, 5)
    static let levelCategories: [(items: [(emoji: String, category: String)], matchCount: Int)] = [
        
        // 🔹 Уровень 1: ПАРЫ (2) — 2 категории × 2
        (
            items: Array(animals.prefix(2)) + Array(plants.prefix(2)),
            matchCount: 2
        ),
        
        // 🔹 Уровень 2: ПАРЫ (2) — 3 категории × 2
        (
            items: Array(animals.shuffled().prefix(2)) + Array(plants.shuffled().prefix(2)) + Array(fruits.shuffled().prefix(2)),
            matchCount: 2
        ),
        
        // 🔹 Уровень 3: ТРОЙКИ (3) — 2 категории × 3
        (
            items: Array(animals.shuffled().prefix(3)) + Array(fruits.shuffled().prefix(3)),
            matchCount: 3
        ),
        
        // 🔹 Уровень 4: ТРОЙКИ (3) — 3 категории × 3
        (
            items: Array(animals.shuffled().prefix(3)) + Array(sports.shuffled().prefix(3)) + Array(music.shuffled().prefix(3)),
            matchCount: 3
        ),
        
        // 🔹 Уровень 5: ЧЕТВЕРКИ (4) — 2 категории × 4
        (
            items: Array(fruits.shuffled().prefix(4)) + Array(sports.shuffled().prefix(4)),
            matchCount: 4
        ),
        
        // 🔹 Уровень 6: ЧЕТВЕРКИ (4) — 3 категории × 4
        (
            items: Array(animals.shuffled().prefix(4)) + Array(music.shuffled().prefix(4)) + Array(food.shuffled().prefix(4)),
            matchCount: 4
        ),
        
        // 🔹 Уровень 7: ПЯТЁРКИ (5) — 2 категории × 5
        (
            items: Array(animals.shuffled().prefix(5)) + Array(fruits.shuffled().prefix(5)),
            matchCount: 5
        ),
        
        // 🔹 Уровень 8: ПЯТЁРКИ (5) — 2 категории × 5 (другие)
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
