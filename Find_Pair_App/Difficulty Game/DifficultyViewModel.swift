import SwiftUI
import Combine

class DifficultyViewModel: ObservableObject {
    @Published var cards: [DifficultyCard] = []
    @Published var moves = 0
    @Published var matchedPairs = 0
    @Published var currentLevel = 1
    @Published var totalPairs = 0
    
    private var firstSelectedCard: DifficultyCard?
    private var isProcessing = false
    
    // Категории для каждого уровня
    private let levelCategories: [[(emoji: String, category: String)]] = [
        // Уровень 1: Животные и Растения (2 пары)
        [
            ("🐨", "animals"), ("🐻", "animals"),  // Животные
            ("🌸", "plants"), ("🌹", "plants")       // Растения
        ],
        // Уровень 2: Животные, Растения, Фрукты (3 пары)
        [
            ("🐶", "animals"), ("🐱", "animals"),
            ("🌺", "plants"), ("🌻", "plants"),
            ("🍎", "fruits"), ("🍊", "fruits")
        ],
        // Уровень 3: Животные, Фрукты, Спорт, Музыка (4 пары)
        [
            ("🐼", "animals"), ("🦊", "animals"),
            ("🍋", "fruits"), ("🍇", "fruits"),
            ("⚽️", "sports"), ("🏀", "sports"),
            ("🎸", "music"), ("🎹", "music")
        ],
        // Уровень 4: 5 категорий (5 пар)
        [
            ("🐸", "animals"), ("🐰", "animals"),
            ("🍓", "fruits"), ("🍑", "fruits"),
            ("🎾", "sports"), ("🏈", "sports"),
            ("🥁", "music"), ("🎺", "music"),
            ("🌈", "nature"), ("⭐️", "nature")
        ],
        // Уровень 5: 6 категорий (6 пар)
        [
            ("🐯", "animals"), ("🐨", "animals"),
            ("🍒", "fruits"), ("🥝", "fruits"),
            ("🎱", "sports"), ("🏓", "sports"),
            ("🎷", "music"), ("🎻", "music"),
            ("🌙", "nature"), ("☀️", "nature"),
            ("🍕", "food"), ("🍔", "food")
        ]
    ]
    
    private let categoryNames: [String: String] = [
        "animals": "🐾 Животные",
        "plants": "🌿 Растения",
        "fruits": "🍎 Фрукты",
        "sports": "⚽️ Спорт",
        "music": "🎵 Музыка",
        "nature": "🌈 Природа",
        "food": "🍕 Еда"
    ]
    
    init() {
        setupLevel()
    }
    
    var currentCategories: [String] {
        let allCategories = cards.map { $0.category }
        return Array(Set(allCategories)).sorted()
    }
    
    func setupLevel() {
        let index = min(currentLevel - 1, levelCategories.count - 1)
        let items = levelCategories[index]
        totalPairs = items.count / 2
        
        let newCards = items.map { DifficultyCard(emoji: $0.emoji, category: $0.category) }
        cards = newCards.shuffled()
        
        moves = 0
        matchedPairs = 0
        firstSelectedCard = nil
        isProcessing = false
    }
    
    var columns: Int {
        let count = cards.count
        if count <= 4 { return 2 }
        if count <= 8 { return 3 }
        return 4
    }
    
    func selectCard(_ card: DifficultyCard) {
        guard !isProcessing,
              let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isMatched,
              !cards[index].isFaceUp else { return }
        
        cards[index].isFaceUp = true
        
        if firstSelectedCard == nil {
            firstSelectedCard = cards[index]
        } else {
            moves += 1
            let first = firstSelectedCard!
            let second = cards[index]
            checkForMatch(first: first, second: second)
        }
    }
    
    private func checkForMatch(first: DifficultyCard, second: DifficultyCard) {
        isProcessing = true
        
        // Проверяем, из одной ли они категории
        let isMatch = first.category == second.category && first.id != second.id
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if isMatch {
                // Нашли пару из одной категории!
                self.cards = self.cards.map { card in
                    var updated = card
                    if card.id == first.id || card.id == second.id {
                        updated.isMatched = true
                    }
                    return updated
                }
                self.matchedPairs += 1
            } else {
                // Разные категории — переворачиваем обратно
                self.cards = self.cards.map { card in
                    var updated = card
                    if card.id == first.id || card.id == second.id {
                        updated.isFaceUp = false
                    }
                    return updated
                }
            }
            
            self.firstSelectedCard = nil
            self.isProcessing = false
        }
    }
    
    func nextLevel() {
        if currentLevel < levelCategories.count {
            currentLevel += 1
            setupLevel()
        }
    }
    
    func restartLevel() {
        setupLevel()
    }
    
    var isLevelComplete: Bool {
        matchedPairs == totalPairs
    }
    
    func categoryName(for category: String) -> String {
        categoryNames[category] ?? category
    }
}

