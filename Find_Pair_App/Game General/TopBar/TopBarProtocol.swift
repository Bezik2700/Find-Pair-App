import SwiftUI

protocol TopBarViewModelProtocol: ObservableObject {
    var currentLevelDisplay: Int { get }
    var timeLimit: Int { get }
    var timeRemaining: Int { get }
    var isTimeUp: Bool { get }
    var clickLimit: Int { get }
    var clicksRemaining: Int { get }
    var isClickLimitExceeded: Bool { get }
    var currentHints: Int { get }
    var totalPairs: Int { get }
    var matchedPairs: Int { get }
    
    func showHint()
    func formatTime(_ seconds: Int) -> String
}

extension GameViewModel: TopBarViewModelProtocol {
    var currentLevelDisplay: Int { currentLevel }
}

extension DifficultyViewModel: TopBarViewModelProtocol {
    var currentLevelDisplay: Int { difficultyCurrentLevel }
    var currentHints: Int { difficultCurrentHints }
}
