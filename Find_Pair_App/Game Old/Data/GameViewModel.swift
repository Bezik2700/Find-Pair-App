import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    
    @Published var cards: [Card] = []
    @Published var moves = 0
    @Published var matchedPairs = 0
    @Published var isHintActive = false
    @Published var totalPairs = 0
    
    @Published var clickLimit = 0
    @Published var clicksRemaining = 0
    @Published var isClickLimitExceeded = false
    
    @Published var timeLimit = 0
    @Published var timeRemaining = 0
    @Published var isTimeUp = false
    
    @Published var currentLevel = 1 {
        didSet { UserDefaults.standard.set(currentLevel, forKey: "currentLevel") }
    }
    
    @Published var currentHints = 0 {
        didSet { UserDefaults.standard.set(currentHints, forKey: "currentHints") }
    }
    
    @Published var maxLevel: Int {
        didSet { UserDefaults.standard.set(maxLevel, forKey: "maxLevel") }
    }
    
    private var firstSelectedCard: Card?
    private var secondSelectedCard: Card?
    private var isProcessing = false
    private var timer: Timer?
    
    var currentLevelData: Level {
        getLevel(for: currentLevel)
    }
    
    init() {
        self.maxLevel = max(UserDefaults.standard.integer(forKey: "maxLevel"), 1)
        self.currentLevel = max(UserDefaults.standard.integer(forKey: "currentLevel"), 1)
        self.currentHints = max(UserDefaults.standard.integer(forKey: "currentHints"), 0)
        setupLevel()
    }
    
    private func getContentType(for levelNumber: Int) -> ContentType {
        let types: [ContentType] = [.emoji, .number, .color]
        return types[(levelNumber - 1) % types.count]
    }
    
    private func getLevel(for levelNumber: Int) -> Level {
        let config = GameData.getLevelConfig(for: levelNumber)
        return Level(
            number: levelNumber,
            pairs: config.pairs,
            columns: config.columns,
            rows: config.rows,
            type: getContentType(for: levelNumber)
        )
    }
    
    func setupLevel() {
        let level = getLevel(for: currentLevel)
        totalPairs = level.pairs
        
        clickLimit = GameData.getClickLimit(for: currentLevel)
        clicksRemaining = clickLimit
        isClickLimitExceeded = false
        
        timeLimit = GameData.getTimeLimit(for: currentLevel)
        timeRemaining = timeLimit
        isTimeUp = false
        
        timeLimit > 0 ? startTimer() : stopTimer()
        
        let contents: [String] = {
            switch level.type {
            case .emoji: return Array(GameData.emojis.shuffled().prefix(level.pairs))
            case .number: return Array(GameData.numbers.shuffled().prefix(level.pairs))
            case .color: return Array(GameData.colors.map(\.name).shuffled().prefix(level.pairs))
            }
        }()
        
        cards = (contents + contents).shuffled().map { Card(type: level.type, content: $0) }
        
        moves = 0
        matchedPairs = 0
        firstSelectedCard = nil
        secondSelectedCard = nil
        isProcessing = false
    }
    
    func nextLevel() {
        currentLevel += 1
        currentHints += 1
        maxLevel = max(maxLevel, currentLevel)
        setupLevel()
    }
    
    func restartLevel() {
        setupLevel()
    }
    
    func selectCard(_ card: Card) {
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
            secondSelectedCard = cards[index]
            moves += 1
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        guard let first = firstSelectedCard, let second = secondSelectedCard else { return }
        isProcessing = true
        
        let isMatch = first.content == second.content
        let delay = isMatch ? 0.3 : 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            if isMatch {
                self.handleMatch(first: first, second: second)
            } else {
                self.handleMismatch(first: first, second: second)
            }
            self.resetSelection()
        }
    }
    
    private func handleMatch(first: Card, second: Card) {
        cards = cards.map { card in
            var updated = card
            if card.id == first.id || card.id == second.id {
                updated.isMatched = true
            }
            return updated
        }
        matchedPairs += 1
        
        if matchedPairs == totalPairs {
            guard !isTimeUp, !(clickLimit > 0 && clicksRemaining < 0) else { return }
            stopTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                self?.nextLevel()
            }
        }
    }
    
    private func handleMismatch(first: Card, second: Card) {
        cards = cards.map { card in
            var updated = card
            if card.id == first.id || card.id == second.id {
                updated.isFaceUp = false
            }
            return updated
        }
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
    
    func showHint() {
        guard !isHintActive, !isProcessing, currentHints > 0 else { return }
        isHintActive = true
        currentHints -= 1
        
        if let first = firstSelectedCard {
            cards.firstIndex(where: { $0.id == first.id }).map { cards[$0].isFaceUp = false }
            firstSelectedCard = nil
        }
        
        cards = cards.map { card in
            var updated = card
            if !card.isMatched { updated.isFaceUp = false }
            return updated
        }
        
        secondSelectedCard = nil
        isProcessing = false
        
        let unmatched = cards.filter { !$0.isMatched }
        guard let pair = findHintPair(in: unmatched) else {
            isHintActive = false
            return
        }
        
        for card in pair {
            cards.firstIndex(where: { $0.id == card.id }).map { cards[$0].isFaceUp = true }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            for card in pair {
                if let index = self.cards.firstIndex(where: { $0.id == card.id }), !self.cards[index].isMatched {
                    self.cards[index].isFaceUp = false
                }
            }
            self.isHintActive = false
        }
        SoundManager.shared.playHintSound()
    }
    
    private func findHintPair(in cards: [Card]) -> [Card]? {
        for card in cards {
            if let pair = cards.first(where: { $0.id != card.id && $0.content == card.content }) {
                return [card, pair]
            }
        }
        return nil
    }
    
    func resetProgress() {
        stopTimer()
        currentLevel = 1
        currentHints = 0
        maxLevel = 1
        ["currentLevel", "maxLevel", "currentHints"].forEach {
            UserDefaults.standard.set($0 == "currentHints" ? 0 : 1, forKey: $0)
        }
        setupLevel()
    }
    
    func addHint() {
        currentHints += 1000
    }
    
    func getColorForCard(_ card: Card) -> Color {
        GameData.colors.first(where: { $0.name == card.content })?.color ?? .gray
    }
    
    func formatTime(_ seconds: Int) -> String {
        String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }
    
    private func resetSelection() {
        firstSelectedCard = nil
        secondSelectedCard = nil
        isProcessing = false
    }
}
