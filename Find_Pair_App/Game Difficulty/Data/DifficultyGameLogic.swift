import SwiftUI

struct DifficultyGameLogic {
    
    static func getDifficultClickLimit(for levelNumber: Int) -> Int {
        guard levelNumber % 3 == 0 else { return 0 }
        
        let limitLevel = levelNumber / 3
        switch limitLevel {
        case 1: return 8 // 3
        case 2: return 20 // 6
        case 3: return 28 // 9
        case 4: return 28 // 12
        case 5: return 48 // 15
        case 6: return 50 // 18
        case 7: return 18 // 21
        case 8: return 18 // 24
        case 9: return 26 // 27
        case 10: return 24 // 30
        case 11: return 36 // 33
        case 12: return 40 // 36
            
        case 13: return 20 // 39
        case 14: return 20 // 42
        case 15: return 20 // 45
        case 16: return 20 // 48
        case 17: return 20 // 51
        case 18: return 20 // 54
        case 19: return 20 // 57
        case 20: return 20 // 60
        case 21: return 20 // 63
        case 22: return 20 // 66
        case 23: return 20 // 69
        case 24: return 20 // 72
        case 25: return 20 // 75
        case 26: return 20 // 78
        case 27: return 20 // 81
        case 28: return 20 // 84
        case 29: return 20 // 87
        case 30: return 20 // 90
        case 31: return 20 // 93
        case 32: return 20 // 96
        case 33: return 20 // 99
        case 34: return 20 // 102
        case 35: return 20 // 105
        case 36: return 20 // 108
        case 37: return 20 // 111
        case 38: return 20 // 114
        case 39: return 20 // 117
        case 40: return 20 // 120
        case 41: return 20 // 123
        case 42: return 20 // 126
        case 43: return 20 // 129
        case 44: return 20 // 132
        case 45: return 20 // 135
        case 46: return 20 // 138
        case 47: return 20 // 141
        case 48: return 20 // 144
        case 49: return 20 // 147
        default: return 20
        }
    }

    static func getDifficultTimeLimit(for levelNumber: Int) -> Int {
        guard levelNumber % 4 == 0 else { return 0 }
        
        let limitLevel = levelNumber / 4
        switch limitLevel {
        case 1: return 10  // 4
        case 2: return 20  // 8
        case 3: return 27  // 12
        case 4: return 48  // 16
        case 5: return 60  // 20
        case 6: return 17  // 24
        case 7: return 25  // 28
        case 8: return 50  // 32
        case 9: return 60  // 36
            
        case 10: return 60  // 40
        case 11: return 60  // 44
        case 12: return 60  // 48
        case 13: return 60  // 52
        case 14: return 60  // 56
        case 15: return 60  // 60
        case 16: return 60  // 64
        case 17: return 60  // 68
        case 18: return 60  // 72
        case 19: return 60  // 76
        case 20: return 60  // 80
        case 21: return 60  // 84
        case 22: return 60  // 88
        case 23: return 60  // 92
        case 24: return 60  // 96
        case 25: return 60  // 100
        case 26: return 60  // 104
        case 27: return 60  // 108
        case 28: return 60  // 112
        case 29: return 60  // 116
        case 30: return 60  // 120
        case 31: return 60  // 124
        case 32: return 60  // 128
        case 33: return 60  // 132
        case 34: return 60  // 136
        case 35: return 60  // 140
        case 36: return 60  // 144
        case 37: return 60  // 148
        default: return 60
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
