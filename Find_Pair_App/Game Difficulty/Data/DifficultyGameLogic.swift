import SwiftUI

struct DifficultyGameLogic {
    
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
        return items.map { DifficultyCard(imageName: $0.imageName, pairID: $0.pairID) }.shuffled()
    }

    static func totalPairs(for level: Int) -> Int {
        let index = min(level - 1, DifficultyGameData.levelCategories.count - 1)
        let data = DifficultyGameData.levelCategories[index]
        return data.items.count / data.matchCount
    }
    
    static func columns(for level: Int) -> Int {
        let index = min(level - 1, DifficultyGameData.levelCategories.count - 1)
        return DifficultyGameData.levelCategories[index].columns
    }
    
    static func findHintPair(in cards: [DifficultyCard], matchCount: Int) -> [DifficultyCard]? {
        let unmatched = cards.filter { !$0.isMatched }
        for card in unmatched {
            let samePair = unmatched.filter { $0.id != card.id && $0.pairID == card.pairID }
            if samePair.count >= matchCount - 1 {
                return Array(samePair.prefix(matchCount - 1)) + [card]
            }
        }
        return nil
    }
}
