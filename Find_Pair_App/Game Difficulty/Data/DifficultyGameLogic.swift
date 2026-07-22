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
        case 9: return 27 // 27
        case 10: return 24 // 30
        case 11: return 36 // 33
        case 12: return 42 // 36
        case 13: return 39 // 39
        case 14: return 48 // 42
        case 15: return 45 // 45
        case 16: return 60 // 48
        case 17: return 90 // 51
        case 18: return 81 // 54
        case 19: return 48 // 57
        case 20: return 36 // 60
        case 21: return 60 // 63
        case 22: return 52 // 66
        case 23: return 72 // 69
        case 24: return 60 // 72
        case 25: return 96 // 75
        case 26: return 68 // 78
        case 27: return 108 // 81
        case 28: return 84 // 84
        case 29: return 120 // 87
        case 30: return 100 // 90
        case 31: return 260 // 93
        case 32: return 252 // 96
        case 33: return 244 // 99
        case 34: return 236 // 102
        case 35: return 228 // 105
        case 36: return 220 // 108
        case 37: return 212 // 111
        case 38: return 204 // 114
        case 39: return 196 // 117
        case 40: return 188 // 120
        case 41: return 180 // 123
        case 42: return 172 // 126
        case 43: return 164 // 129
        case 44: return 156 // 132
        case 45: return 144 // 135
        case 46: return 136 // 138
        case 47: return 128 // 141
        case 48: return 120 // 144
        case 49: return 112 // 147
        case 50: return 104 // 150
        default: return 96
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
        case 10: return 55  // 40
        case 11: return 65  // 44
        case 12: return 70  // 48
        case 13: return 120  // 52
        case 14: return 45  // 56
        case 15: return 38  // 60
        case 16: return 55  // 64
        case 17: return 60  // 68
        case 18: return 55  // 72
        case 19: return 115  // 76
        case 20: return 135  // 80
        case 21: return 100  // 84
        case 22: return 150  // 88
        case 23: return 240  // 92
        case 24: return 230  // 96
        case 25: return 220  // 100
        case 26: return 210  // 104
        case 27: return 200  // 108
        case 28: return 190  // 112
        case 29: return 185  // 116
        case 30: return 175  // 120
        case 31: return 165  // 124
        case 32: return 160  // 128
        case 33: return 155  // 132
        case 34: return 150  // 136
        case 35: return 145  // 140
        case 36: return 140  // 144
        case 37: return 130  // 148
        case 38: return 125  // 152
        default: return 120
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
