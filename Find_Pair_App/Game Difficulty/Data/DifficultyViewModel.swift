import SwiftUI
import Combine

// DifficultyViewModel.swift
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
    
    @Published var requiredMatches: Int = 2  // ← Сколько нужно найти (2,3,4,5)
        
    @Published var difficultyCurrentLevel = 1 {
        didSet { UserDefaults.standard.set(difficultyCurrentLevel, forKey: "difficultyCurrentLevel") }
    }
        
    @Published var difficultyMaxLevel: Int {
        didSet { UserDefaults.standard.set(difficultyMaxLevel, forKey: "difficultyMaxLevel") }
    }
    
    @Published var difficultCurrentHints = 0 {
        didSet { UserDefaults.standard.set(difficultCurrentHints, forKey: "difficultCurrentHints") }
    }
        
    private var selectedCards: [DifficultyCard] = []  // ← Несколько выбранных карточек
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
    
    var columns: Int {
        DifficultyGameLogic.columns(for: cards.count)
    }
    
    var levelDescription: String {
        switch requiredMatches {
        case 2: return "Найди пары"
        case 3: return "Найди тройки"
        case 4: return "Найди четверки"
        case 5: return "Найди пятёрки"
        default: return "Найди \(requiredMatches) одинаковых"
        }
    }
    
    // MARK: - Уровень
    func setupLevel() {
        requiredMatches = DifficultyGameLogic.matchCount(for: difficultyCurrentLevel)
        totalPairs = DifficultyGameLogic.totalPairs(for: difficultyCurrentLevel)
        cards = DifficultyGameLogic.createCards(for: difficultyCurrentLevel)
        
        clickLimit = DifficultyGameLogic.getDifficultClickLimit(for: difficultyCurrentLevel)
        clicksRemaining = clickLimit
        isClickLimitExceeded = false
        
        timeLimit = DifficultyGameLogic.getDifficultTimeLimit(for: difficultyCurrentLevel)
        timeRemaining = timeLimit
        isTimeUp = false
        
        timeLimit > 0 ? startTimer() : stopTimer()
        
        moves = 0
        matchedPairs = 0
        selectedCards = []
        isProcessing = false
    }
    
    // MARK: - Выбор карточки (несколько!)
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
        selectedCards.append(cards[index])
        
        // Проверяем, когда набрали нужное количество
        if selectedCards.count == requiredMatches {
            moves += 1
            checkForMatch()
        }
    }
    
    // MARK: - Проверка совпадения (для нескольких карточек)
    private func checkForMatch() {
        isProcessing = true
        
        let firstCategory = selectedCards[0].category
        let allMatch = selectedCards.allSatisfy { $0.category == firstCategory }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if allMatch {
                let matchedIDs = self.selectedCards.map { $0.id }
                self.cards = self.cards.map { card in
                    var updated = card
                    if matchedIDs.contains(card.id) { updated.isMatched = true }
                    return updated
                }
                self.matchedPairs += 1
                
                if self.matchedPairs == self.totalPairs {
                    guard !self.isTimeUp, !(self.clickLimit > 0 && self.clicksRemaining < 0) else { return }
                    self.stopTimer()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { self.nextLevel() }
                }
            } else {
                let selectedIDs = self.selectedCards.map { $0.id }
                self.cards = self.cards.map { card in
                    var updated = card
                    if selectedIDs.contains(card.id) { updated.isFaceUp = false }
                    return updated
                }
            }
            
            self.selectedCards = []
            self.isProcessing = false
        }
    }
    
    // MARK: - Подсказка (показывает нужное количество карточек)
    func showHint() {
        guard !isHintActive, !isProcessing else { return }
        isHintActive = true
        difficultCurrentHints -= 1
        
        var updatedCards = cards
        for i in updatedCards.indices {
            if !updatedCards[i].isMatched { updatedCards[i].isFaceUp = false }
        }
        selectedCards = []
        isProcessing = false
        
        let unmatched = updatedCards.filter { !$0.isMatched }
        guard let hintGroup = DifficultyGameLogic.findHintPair(in: unmatched, matchCount: requiredMatches) else {
            withAnimation(.easeInOut(duration: 0.4)) { cards = updatedCards }
            isHintActive = false
            return
        }
        
        for hintCard in hintGroup {
            if let index = updatedCards.firstIndex(where: { $0.id == hintCard.id }) {
                updatedCards[index].isFaceUp = true
            }
        }
        
        withAnimation(.easeInOut(duration: 0.4)) { cards = updatedCards }
        
        let hintIDs = hintGroup.map { $0.id }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            var closedCards = self.cards
            for id in hintIDs {
                if let index = closedCards.firstIndex(where: { $0.id == id }), !closedCards[index].isMatched {
                    closedCards[index].isFaceUp = false
                }
            }
            withAnimation(.easeInOut(duration: 0.4)) { self.cards = closedCards }
            self.isHintActive = false
        }
        SoundManager.shared.playHintSound()
    }
    
    // MARK: - Таймер
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
    
    // MARK: - Уровни
    func nextLevel() {
        if difficultyCurrentLevel < DifficultyGameLogic.totalLevels {
            difficultyCurrentLevel += 1
            difficultCurrentHints += 1
            difficultyMaxLevel = max(difficultyMaxLevel, difficultyCurrentLevel)
            setupLevel()
        }
    }
    
    func restartLevel() {
        setupLevel()
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
    
    func addHintShowReward() {
        difficultCurrentHints += 10
    }
    
    var isLevelComplete: Bool {
        matchedPairs == totalPairs
    }
    
    func categoryName(for category: String) -> String {
        DifficultyGameLogic.categoryName(for: category)
    }
}
