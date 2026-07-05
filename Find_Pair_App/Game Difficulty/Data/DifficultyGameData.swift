import SwiftUI

struct DifficultyGameData {
    
    static let myCards: [(imageName: String, pairID: String)] = [
        ("IMG_0657", "pair_1"), ("IMG_0658", "pair_1"), ("IMG_0659", "pair_1"), ("IMG_0660", "pair_1"),
        ("IMG_0661", "pair_2"), ("IMG_0662", "pair_2"), ("IMG_0663", "pair_2"), ("IMG_0664", "pair_2"),
        ("IMG_0665", "pair_3"), ("IMG_0666", "pair_3"), ("IMG_0667", "pair_3"), ("IMG_0668", "pair_3"),
        ("IMG_0669", "pair_4"), ("IMG_0670", "pair_4"), ("IMG_0671", "pair_4"), ("IMG_0672", "pair_4"),
        ("IMG_0673", "pair_5"), ("IMG_0674", "pair_5"), ("IMG_0675", "pair_5"), ("IMG_0676", "pair_5"),
        ("IMG_0677", "pair_6"), ("IMG_0678", "pair_6"), ("IMG_0679", "pair_6"), ("IMG_0680", "pair_6"),
        ("IMG_0681", "pair_7"), ("IMG_0682", "pair_7"), ("IMG_0683", "pair_7"), ("IMG_0684", "pair_7"),
        ("IMG_0685", "pair_8"), ("IMG_0686", "pair_8"), ("IMG_0687", "pair_8"), ("IMG_0688", "pair_8"),
        ("IMG_0689", "pair_9"), ("IMG_0690", "pair_9"), ("IMG_0691", "pair_9"), ("IMG_0692", "pair_9"),
        ("IMG_0693", "pair_10"), ("IMG_0694", "pair_10"), ("IMG_0695", "pair_10"), ("IMG_0696", "pair_10"),
        ("IMG_0697", "pair_11"), ("IMG_0698", "pair_11"), ("IMG_0699", "pair_11"), ("IMG_0700", "pair_11"),
        ("IMG_0701", "pair_12"), ("IMG_0702", "pair_12"), ("IMG_0703", "pair_12"), ("IMG_0704", "pair_12"),
        ("IMG_0705", "pair_13"), ("IMG_0706", "pair_13"), ("IMG_0707", "pair_13"), ("IMG_0708", "pair_13"),
        ("IMG_0709", "pair_14"), ("IMG_0710", "pair_14"), ("IMG_0711", "pair_14"), ("IMG_0712", "pair_14"),
        ("IMG_0713", "pair_15"), ("IMG_0714", "pair_15"), ("IMG_0715", "pair_15"), ("IMG_0716", "pair_15"),
        ("IMG_0717", "pair_16"), ("IMG_0718", "pair_16"), ("IMG_0719", "pair_16"), ("IMG_0720", "pair_16"),
        ("IMG_0721", "pair_17"), ("IMG_0722", "pair_17"), ("IMG_0723", "pair_17"), ("IMG_0724", "pair_17"),
        ("IMG_0725", "pair_18"), ("IMG_0726", "pair_18"), ("IMG_0727", "pair_18"), ("IMG_0728", "pair_18"),
        ("IMG_0729", "pair_19"), ("IMG_0730", "pair_19"), ("IMG_0731", "pair_19"), ("IMG_0732", "pair_19"),
        ("IMG_0733", "pair_20"), ("IMG_0734", "pair_20"), ("IMG_0735", "pair_20"), ("IMG_0736", "pair_20"),
        ("IMG_0737", "pair_21"), ("IMG_0738", "pair_21"), ("IMG_0739", "pair_21"), ("IMG_0740", "pair_21")
    ]
    
    static func cardsFromRandomGroups(_ groupCount: Int, cardsPerGroup: Int) -> [(imageName: String, pairID: String)] {
        let allPairIDs = Array(Set(myCards.map { $0.pairID })).shuffled()
        let selectedPairIDs = Array(allPairIDs.prefix(groupCount))
        
        var result: [(imageName: String, pairID: String)] = []
        for pairID in selectedPairIDs {
            let groupCards = myCards.filter { $0.pairID == pairID }
            result += Array(groupCards.shuffled().prefix(cardsPerGroup))
        }
        return result
    }
    
    static let levelCategories: [(items: [(imageName: String, pairID: String)], matchCount: Int, columns: Int)] = [
        (items: cardsFromRandomGroups(2, cardsPerGroup: 2), matchCount: 2, columns: 2),
        (items: cardsFromRandomGroups(4, cardsPerGroup: 2), matchCount: 2, columns: 3),
        (items: cardsFromRandomGroups(6, cardsPerGroup: 2), matchCount: 2, columns: 3),
        
        // Уровень 4: ТРОЙКИ — 2 группы × 3 карточки (6 карточек, сетка 3×2)
        /*(items: cardsFromRandomGroups(2, cardsPerGroup: 3), matchCount: 3),
        
        // Уровень 5: ТРОЙКИ — 3 группы × 3 карточки (9 карточек, сетка 3×3)
        (items: cardsFromRandomGroups(3, cardsPerGroup: 3), matchCount: 3),
        
        // Уровень 6: ТРОЙКИ — 4 группы × 3 карточки (12 карточек, сетка 4×3)
        (items: cardsFromRandomGroups(4, cardsPerGroup: 3), matchCount: 3),
        
        // Уровень 7: ЧЕТВЕРКИ — 2 группы × 4 карточки (8 карточек, сетка 4×2)
        (items: cardsFromRandomGroups(2, cardsPerGroup: 4), matchCount: 4),
        
        // Уровень 8: ЧЕТВЕРКИ — 3 группы × 4 карточки (12 карточек, сетка 4×3)
        (items: cardsFromRandomGroups(3, cardsPerGroup: 4), matchCount: 4),
        
        // Уровень 9: ЧЕТВЕРКИ — 4 группы × 4 карточки (16 карточек, сетка 4×4)
        (items: cardsFromRandomGroups(4, cardsPerGroup: 4), matchCount: 4),
        
        // Уровень 10: ЧЕТВЕРКИ — 5 групп × 4 карточки (20 карточек, сетка 5×4)
        (items: cardsFromRandomGroups(5, cardsPerGroup: 4), matchCount: 4)*/
    ]
}
