import SwiftUI

// DifficultyGameLogic.swift
struct DifficultyGameLogic {
    
    // MARK: - Лимиты
    static func getDifficultClickLimit(for levelNumber: Int) -> Int {
        guard levelNumber % 3 == 0 else { return 0 }
        
        let limitLevel = levelNumber / 3
        switch limitLevel {
        case 1: return 30
        case 2: return 30
        case 3: return 50
        case 4: return 100
        case 5: return 100
        default: return 150
        }
    }

    static func getDifficultTimeLimit(for levelNumber: Int) -> Int {
        guard levelNumber % 4 == 0 else { return 0 }
        
        switch levelNumber {
        case 4: return 25
        case 8: return 35
        default: return levelNumber * 5
        }
    }
    
    // MARK: - Уровни
    static var totalLevels: Int {
        DifficultyGameData.levelCategories.count
    }
    
    static func matchCount(for level: Int) -> Int {
        let index = min(level - 1, DifficultyGameData.levelCategories.count - 1)
        return DifficultyGameData.levelCategories[index].matchCount
    }
    
    static func createCards(for level: Int) -> [DifficultyCard] {
        let index = min(level - 1, DifficultyGameData.levelCategories.count - 1)
        let items = DifficultyGameData.levelCategories[index].items
        return items.map { DifficultyCard(emoji: $0.emoji, category: $0.category) }.shuffled()
    }
    
    static func totalPairs(for level: Int) -> Int {
        let index = min(level - 1, DifficultyGameData.levelCategories.count - 1)
        let data = DifficultyGameData.levelCategories[index]
        return data.items.count / data.matchCount
    }
    
    static func columns(for cardCount: Int) -> Int {
        if cardCount <= 4 { return 2 }
        if cardCount <= 9 { return 3 }
        return 4
    }
    
    // MARK: - Подсказка
    static func findHintPair(in cards: [DifficultyCard], matchCount: Int) -> [DifficultyCard]? {
        let unmatched = cards.filter { !$0.isMatched }
        for card in unmatched {
            let sameCategory = unmatched.filter { $0.id != card.id && $0.category == card.category }
            if sameCategory.count >= matchCount - 1 {
                return Array(sameCategory.prefix(matchCount - 1)) + [card]
            }
        }
        return nil
    }
    
    static func categoryName(for category: String) -> String {
        DifficultyGameData.categoryNames[category] ?? category
    }
}
