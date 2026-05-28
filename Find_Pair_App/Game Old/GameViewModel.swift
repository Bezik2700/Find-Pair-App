import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var moves = 0
    @Published var matchedPairs = 0
    @Published var isHintActive = false
    @Published var totalPairs = 0
    
    @Published var clickLimit: Int = 0
    @Published var clicksRemaining: Int = 0
    @Published var isClickLimitExceeded = false
    
    @Published var timeLimit: Int = 0  // Лимит времени в секундах
    @Published var timeRemaining: Int = 0  // Оставшееся время
    @Published var isTimeUp = false  // Флаг окончания времени
    private var timer: Timer?  // Таймер
    
    @Published var currentLevel = 1 {
        didSet {
            UserDefaults.standard.set(currentLevel, forKey: "currentLevel")
        }
    }
    @Published var currentHints = 0 {
        didSet {
            UserDefaults.standard.set(currentHints, forKey: "currentHints")
        }
    }
    
    @Published var maxLevel: Int {
        didSet {
            UserDefaults.standard.set(maxLevel, forKey: "maxLevel")
        }
    }
    
    private var firstSelectedCard: Card?
    private var secondSelectedCard: Card?
    private var isProcessing = false
    
    var currentLevelData: Level {
        getLevel(for: currentLevel)
    }
    
    init() {
        let savedMaxLevel = UserDefaults.standard.integer(forKey: "maxLevel")
        self.maxLevel = savedMaxLevel > 0 ? savedMaxLevel : 1
            
        let savedCurrentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
        self.currentLevel = savedCurrentLevel > 0 ? savedCurrentLevel : 1
        
        let savedCurrentHints = UserDefaults.standard.integer(forKey: "currentHints")
        self.currentHints = savedCurrentHints > 0 ? savedCurrentHints : 0
            
        setupLevel()
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
    
    private func getTimeLimit(for levelNumber: Int) -> Int {
        let limitLevel = levelNumber / 5  // 0, 1, 2, 3...
        
        if levelNumber % 5 == 0 {
            // Уровни 5, 10, 15, 20...
            switch limitLevel {
            case 1: return 30   // Уровень 5: 30 секунд
            case 2: return 45   // Уровень 10: 45 секунд
            case 3: return 60   // Уровень 15: 60 секунд
            case 4: return 75   // Уровень 20: 75 секунд
            case 5: return 90   // Уровень 25: 90 секунд
            default: return limitLevel * 15 + 15  // Дальше +15 секунд за уровень
            }
        }
        
        return 0  // 0 означает без ограничений
    }
    
    private func getClickLimit(for levelNumber: Int) -> Int {
        let limitLevel = levelNumber / 4
        
        if levelNumber % 4 == 0 {
            switch limitLevel {
            case 1: return 15
            case 2: return 25
            case 3: return 35
            case 4: return 45
            case 5: return 55
            default: return limitLevel * 10
            }
        }
        
        return 0
    }
    
    private func getContentType(for levelNumber: Int) -> ContentType {
        let remainder = (levelNumber - 1) % 3
        
        switch remainder {
        case 0:
            return .emoji
        case 1:
            return .number
        case 2:
            return .color
        default:
            return .emoji
        }
    }
    
    private func getLevel(for levelNumber: Int) -> Level {
        let config: (pairs: Int, columns: Int, rows: Int) = {
            switch levelNumber {
            case 1...2:  return (2, 2, 2)
            case 3...4:  return (4, 3, 3)
            case 5...6:  return (6, 3, 4)
            case 7...8:  return (8, 4, 4)
            case 9...10: return (10, 4, 5)
            case 11...12: return (12, 4, 6)
            case 13...14: return (15, 5, 6)
            case 15...16: return (17, 5, 7)
            case 17...18: return (21, 6, 7)
            default:      return (24, 6, 8)
            }
        }()
        
        return Level(
            number: levelNumber,
            pairs: config.pairs,
            columns: config.columns,
            rows: config.rows,
            type:getContentType(for: levelNumber)
        )
    }
    
    let emojis = [
        // Цветы
        "🌸", "🌺", "🌻", "🌹", "🌷", "🌼", "💐", "🪷",
        // Фрукты
        "🍎", "🍊", "🍋", "🍇", "🍓", "🍑", "🍒", "🥝",
        // Музыка
        "🎸", "🎹", "🥁", "🎺", "🎷", "🎻", "🪕", "🎵",
        // Спорт
        "⚽️", "🏀", "🎾", "🏈", "⚾️", "🏐", "🎱", "🏓",
        // Животные
        "🐶", "🐱", "🐼", "🐨", "🐸", "🦊", "🐰", "🐯",
        // Еда
        "🍕", "🍔", "🌮", "🍩", "🎂", "🍪", "🧁", "🍿",
        // Транспорт
        "🚗", "✈️", "🚀", "⛵️", "🚲", "🚁", "🛴", "🏍️",
        // Погода и природа
        "🌈", "⭐️", "🌙", "☀️", "⚡️", "❄️", "🌊", "🔥"
    ]
    
    let numbers = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
        "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
        "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
        "51", "52", "53", "54", "55", "56", "57", "58", "59", "60",
        "61", "62", "63", "64", "65", "66", "67", "68", "69", "70",
        "71", "72", "73", "74", "75", "76", "77", "78", "79", "80",
        "81", "82", "83", "84", "85", "86", "87", "88", "89", "90",
        "91", "92", "93", "94", "95", "96", "97", "98", "99", "100"
    ]
        
    let colors: [(name: String, color: Color)] = [
        // Красные оттенки
        ("Красный", .red),
        ("Тёмно-красный", Color(red: 0.55, green: 0.0, blue: 0.0)),
        ("Малиновый", Color(red: 0.86, green: 0.08, blue: 0.24)),
        ("Бордовый", Color(red: 0.5, green: 0.0, blue: 0.13)),
        ("Алый", Color(red: 1.0, green: 0.14, blue: 0.0)),
        ("Кирпичный", Color(red: 0.7, green: 0.13, blue: 0.13)),
        
        // Синие оттенки
        ("Синий", .blue),
        ("Тёмно-синий", Color(red: 0.0, green: 0.0, blue: 0.55)),
        ("Голубой", .cyan),
        ("Небесный", Color(red: 0.53, green: 0.81, blue: 0.98)),
        ("Лазурный", Color(red: 0.0, green: 0.5, blue: 1.0)),
        ("Индиго", Color(red: 0.29, green: 0.0, blue: 0.51)),
        ("Бирюзовый", Color(red: 0.25, green: 0.88, blue: 0.82)),
        ("Васильковый", Color(red: 0.39, green: 0.58, blue: 0.93)),
        
        // Зелёные оттенки
        ("Зелёный", .green),
        ("Тёмно-зелёный", Color(red: 0.0, green: 0.39, blue: 0.0)),
        ("Салатовый", Color(red: 0.6, green: 0.98, blue: 0.6)),
        ("Изумрудный", Color(red: 0.31, green: 0.78, blue: 0.47)),
        ("Мятный", Color(red: 0.6, green: 0.9, blue: 0.75)),
        ("Оливковый", Color(red: 0.42, green: 0.56, blue: 0.14)),
        ("Лайм", Color(red: 0.75, green: 1.0, blue: 0.0)),
        ("Лесной", Color(red: 0.13, green: 0.55, blue: 0.13)),
        
        // Жёлтые и оранжевые
        ("Жёлтый", .yellow),
        ("Оранжевый", .orange),
        ("Золотой", Color(red: 1.0, green: 0.84, blue: 0.0)),
        ("Янтарный", Color(red: 1.0, green: 0.75, blue: 0.0)),
        ("Персиковый", Color(red: 1.0, green: 0.85, blue: 0.73)),
        ("Абрикосовый", Color(red: 0.98, green: 0.67, blue: 0.42)),
        ("Мандариновый", Color(red: 0.96, green: 0.53, blue: 0.18)),
        ("Канареечный", Color(red: 0.99, green: 0.98, blue: 0.39)),
        
        // Фиолетовые и розовые
        ("Фиолетовый", .purple),
        ("Розовый", .pink),
        ("Пурпурный", Color(red: 0.5, green: 0.0, blue: 0.5)),
        ("Сиреневый", Color(red: 0.78, green: 0.64, blue: 0.78)),
        ("Лавандовый", Color(red: 0.9, green: 0.9, blue: 0.98)),
        ("Фуксия", Color(red: 1.0, green: 0.0, blue: 1.0)),
        ("Лиловый", Color(red: 0.85, green: 0.7, blue: 0.85)),
        ("Сливовый", Color(red: 0.87, green: 0.63, blue: 0.87)),
        ("Маджента", Color(red: 1.0, green: 0.0, blue: 0.5)),
        
        // Нейтральные и другие
        ("Белый", .white),
        ("Серый", .gray),
        ("Чёрный", .black),
        ("Коричневый", .brown),
        ("Бежевый", Color(red: 0.96, green: 0.96, blue: 0.86)),
        ("Кремовый", Color(red: 1.0, green: 0.99, blue: 0.82)),
        ("Песочный", Color(red: 0.94, green: 0.87, blue: 0.64)),
        ("Шоколадный", Color(red: 0.55, green: 0.27, blue: 0.07)),
        ("Каштановый", Color(red: 0.59, green: 0.29, blue: 0.0)),
        ("Коралловый", Color(red: 1.0, green: 0.5, blue: 0.31)),
        ("Циан", Color(red: 0.0, green: 1.0, blue: 1.0))
    ]
    
    func setupLevel() {
        let level = getLevel(for: currentLevel)
        totalPairs = level.pairs
        let contents: [String]
        
        clickLimit = getClickLimit(for: currentLevel)
        clicksRemaining = clickLimit
        isClickLimitExceeded = false
        
        timeLimit = getTimeLimit(for: currentLevel)
        timeRemaining = timeLimit
        isTimeUp = false
            
        // Запускаем таймер если есть лимит
        if timeLimit > 0 {
            startTimer()
        } else {
            stopTimer()
        }

        switch level.type {
        case .emoji:
            contents = Array(emojis.shuffled().prefix(level.pairs))
        case .number:
            contents = Array(numbers.shuffled().prefix(level.pairs))
        case .color:
            contents = Array(colors.map { $0.name }.shuffled().prefix(level.pairs))
        }
        
        let pairedContents = (contents + contents).shuffled()
        
        cards = pairedContents.map { content in
            Card(type: level.type, content: content)
        }
        
        moves = 0
        matchedPairs = 0
        firstSelectedCard = nil
        secondSelectedCard = nil
        isProcessing = false
    }
    
    func nextLevel() {
        currentLevel += 1
        currentHints += 1
        if currentLevel > maxLevel {
                        maxLevel = currentLevel
                    }
        setupLevel()
    }
    
    func selectCard(_ card: Card) {
        guard !isProcessing,
              !isTimeUp,
              !isClickLimitExceeded,
              let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isMatched,
              !cards[index].isFaceUp else { return }
        
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
        guard let first = firstSelectedCard,
              let second = secondSelectedCard else { return }
        
        isProcessing = true
        
        if first.content == second.content {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                self.cards = self.cards.map { card in
                    var updatedCard = card
                    if card.id == first.id || card.id == second.id {
                        updatedCard.isMatched = true
                    }
                    return updatedCard
                }
                self.matchedPairs += 1
                self.resetSelection()
                
                if self.matchedPairs == self.totalPairs {
                    if self.isTimeUp {
                        return  // Время вышло - не переходим
                    }
                    if self.clickLimit > 0 && self.clicksRemaining < 0 {
                    self.isClickLimitExceeded = true
                    return  // Не переходим на следующий уровень
                    }
                    self.stopTimer()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.nextLevel()
                    }
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                self.cards = self.cards.map { card in
                    var updatedCard = card
                    if card.id == first.id || card.id == second.id {
                        updatedCard.isFaceUp = false
                    }
                    return updatedCard
                }
                self.resetSelection()
            }
        }
    }
    
    func  showHint() {
        guard !isHintActive, !isProcessing, currentHints > 0 else { return }
        isHintActive = true
        
        if let first = firstSelectedCard {
            if let index = cards.firstIndex(where: { $0.id == first.id }) {
                cards[index].isFaceUp = false
            }
            firstSelectedCard = nil
        }
        
        // 2. Закрываем все открытые несовпавшие карточки
        for i in cards.indices {
            if !cards[i].isMatched && cards[i].isFaceUp {
                cards[i].isFaceUp = false
            }
        }
        
        // 3. Сбрасываем текущий выбор
        secondSelectedCard = nil
        isProcessing = false
        
        // 4. Находим пару для подсказки
        let unmatchedCards = cards.filter { !$0.isMatched }
        var hintPair: [Card] = []
        
        for card in unmatchedCards {
            if let pair = unmatchedCards.first(where: { $0.id != card.id && $0.content == card.content }) {
                hintPair = [card, pair]
                break
            }
        }
        
        // 5. Показываем подсказку
        if hintPair.count == 2 {
            // Открываем карточки подсказки
            for hintCard in hintPair {
                if let index = cards.firstIndex(where: { $0.id == hintCard.id }) {
                    cards[index].isFaceUp = true
                }
            }
            
            // Закрываем через 1.5 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                for hintCard in hintPair {
                    if let index = self.cards.firstIndex(where: { $0.id == hintCard.id }) {
                        if !self.cards[index].isMatched {
                            self.cards[index].isFaceUp = false
                        }
                    }
                }
                self.isHintActive = false
            }
        } else {
            isHintActive = false
        }
        currentHints -= 1
    }
    
    func resetProgress() {
        currentLevel = 1
        currentHints = 0
        maxLevel = 1
        clickLimit = 0
        clicksRemaining = 0
        isClickLimitExceeded = false
        timeLimit = 0
        timeRemaining = 0
        isTimeUp = false
        stopTimer()
        UserDefaults.standard.set(0, forKey: "currentHint")
        UserDefaults.standard.set(1, forKey: "currentLevel")
        UserDefaults.standard.set(1, forKey: "maxLevel")
        setupLevel()
    }
    
    func restartLevel() {
        setupLevel()
    }
    
    func addHint() {
        currentHints += 1000
    }
    
    func getColorForCard(_ card: Card) -> Color {
        if card.type == .color {
            if let colorTuple = colors.first(where: { $0.name == card.content }) {
                return colorTuple.color
            }
        }
        return .gray
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    private func resetSelection() {
        firstSelectedCard = nil
        secondSelectedCard = nil
        isProcessing = false
    }
}
