import SwiftUI
import Combine

class DifficultyViewModel: ObservableObject {
    @Published var cards: [DifficultyCard] = []
    @Published var moves = 0
    @Published var matchedPairs = 0
    @Published var totalPairs = 0
    
    @Published var isHintActive = false
    @Published var clickLimit = 0
    @Published var clicksRemaining = 0
    @Published var isClickLimitExceeded = false
    @Published var timeLimit = 0
    @Published var timeRemaining = 0
    @Published var isTimeUp = false
        
    @Published var difficultyCurrentLevel = 1 {
        didSet { UserDefaults.standard.set(difficultyCurrentLevel, forKey: "difficultyCurrentLevel") }
    }
        
    @Published var difficultyMaxLevel: Int {
        didSet { UserDefaults.standard.set(difficultyMaxLevel, forKey: "difficultyMaxLevel") }
    }
    
    @Published var difficultCurrentHints = 0 {
        didSet { UserDefaults.standard.set(difficultCurrentHints, forKey: "difficultCurrentHints") }
    }
        
    private var firstSelectedCard: DifficultyCard?
    private var isProcessing = false
    private var timer: Timer?
        
    init() {
        self.difficultyMaxLevel = max(UserDefaults.standard.integer(forKey: "difficultyMaxLevel"), 1)
        self.difficultyCurrentLevel = max(UserDefaults.standard.integer(forKey: "difficultyCurrentLevel"), 1)
        self.difficultCurrentHints = max(UserDefaults.standard.integer(forKey: "difficultCurrentHints"), 0)
        setupLevel()
    }
        
    var currentCategories: [String] {
        let allCategories = cards.map { $0.category }
        return Array(Set(allCategories)).sorted()
    }
    
    func setupLevel() {
        let index = min(difficultyCurrentLevel - 1, DifficultyGameData.levelCategories.count - 1)
        let items = DifficultyGameData.levelCategories[index]
        totalPairs = items.count / 2
        
        clickLimit = GameData.getClickLimit(for: difficultyCurrentLevel)
        clicksRemaining = clickLimit
        isClickLimitExceeded = false
        
        timeLimit = GameData.getTimeLimit(for: difficultyCurrentLevel)
        timeRemaining = timeLimit
        isTimeUp = false
        
        timeLimit > 0 ? startTimer() : stopTimer()
        
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
        guard !isProcessing, !isTimeUp, !isClickLimitExceeded,
              let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isMatched, !cards[index].isFaceUp
        else { return }
        
        if clickLimit > 0 {
            guard clicksRemaining > 0 else {
                isClickLimitExceeded = true
                return
            }
            clicksRemaining -= 1
        }
        
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
    
    func showHint() {
        guard !isHintActive, !isProcessing else { return }
        isHintActive = true
        difficultCurrentHints -= 1
        
        var updatedCards = cards
        for i in updatedCards.indices {
            if !updatedCards[i].isMatched {
                updatedCards[i].isFaceUp = false
            }
        }
        
        isProcessing = false
        
        let unmatched = updatedCards.filter { !$0.isMatched }
        guard let pair = findHintPair(in: unmatched) else {
            withAnimation(.easeInOut(duration: 0.4)) { // ← Плавное закрытие остальных
                cards = updatedCards
            }
            isHintActive = false
            return
        }
        
        for hintCard in pair {
            if let index = updatedCards.firstIndex(where: { $0.id == hintCard.id }) {
                updatedCards[index].isFaceUp = true
            }
        }
        
        // ✅ Открываем подсказку с плавной анимацией
        withAnimation(.easeInOut(duration: 0.4)) {
            cards = updatedCards
        }
        
        let pairIDs = pair.map { $0.id }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in // 1.5 сек чтобы успели рассмотреть
            guard let self = self else { return }
            
            var closedCards = self.cards
            for id in pairIDs {
                if let index = closedCards.firstIndex(where: { $0.id == id }), !closedCards[index].isMatched {
                    closedCards[index].isFaceUp = false
                }
            }
            
            // ✅ Закрываем подсказку с плавной анимацией
            withAnimation(.easeInOut(duration: 0.4)) {
                self.cards = closedCards
            }
            self.isHintActive = false
        }
        SoundManager.shared.playHintSound()
    }

    
    private func findHintPair(in cards: [DifficultyCard]) -> [DifficultyCard]? {
        for card in cards {
            if let pair = cards.first(where: { $0.id != card.id && $0.category == card.category }) {
                return [card, pair]
            }
        }
        return nil
    }
    
    func startTimer() {
        guard timeLimit > 0 else { return }
        timeRemaining = timeLimit
        isTimeUp = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.isTimeUp = true
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func formatTime(_ seconds: Int) -> String {
        String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }
    
    private func checkForMatch(first: DifficultyCard, second: DifficultyCard) {
        isProcessing = true
        let isMatch = first.category == second.category && first.id != second.id
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if isMatch {
                self.cards = self.cards.map { card in
                    var updated = card
                    if card.id == first.id || card.id == second.id {
                        updated.isMatched = true
                    }
                    return updated
                }
                self.matchedPairs += 1
                
                if self.matchedPairs == self.totalPairs {
                    guard !self.isTimeUp, !(self.clickLimit > 0 && self.clicksRemaining < 0) else { return }
                    self.stopTimer()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.nextLevel()
                    }
                }
            } else {
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
    
    func categoryName(for category: String) -> String {
        DifficultyGameData.categoryNames[category] ?? category
    }
        
    func nextLevel() {
        if difficultyCurrentLevel < DifficultyGameData.levelCategories.count {
            difficultyCurrentLevel += 1
            difficultCurrentHints += 1
            difficultyMaxLevel = max(difficultyMaxLevel, difficultyCurrentLevel)
            setupLevel()
        }
    }
    
    func addHintShowReward() {
        difficultCurrentHints += 10
    }
    
    func resetProgress() {
        stopTimer()
        difficultyCurrentLevel = 1
        difficultCurrentHints = 0
        difficultyMaxLevel = 1
        UserDefaults.standard.set(1, forKey: "difficultyCurrentLevel")
        UserDefaults.standard.set(1, forKey: "difficultyMaxLevel")
        UserDefaults.standard.set(0, forKey: "difficultCurrentHints")
        setupLevel()
    }
    
    func restartLevel() {
        setupLevel()
    }
    
    var isLevelComplete: Bool {
        matchedPairs == totalPairs
    }
}
