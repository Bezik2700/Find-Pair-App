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
        ("IMG_0737", "pair_21"), ("IMG_0738", "pair_21"), ("IMG_0739", "pair_21"), ("IMG_0740", "pair_21"),
        ("IMG_0741", "pair_22"), ("IMG_0742", "pair_22"), ("IMG_0743", "pair_22"), ("IMG_0744", "pair_22"),
        ("IMG_0745", "pair_23"), ("IMG_0746", "pair_23"), ("IMG_0747", "pair_23"), ("IMG_0748", "pair_23"),
        ("IMG_0749", "pair_24"), ("IMG_0750", "pair_24"), ("IMG_0751", "pair_24"), ("IMG_0752", "pair_24"),
        ("IMG_0753", "pair_25"), ("IMG_0754", "pair_25"), ("IMG_0755", "pair_25"), ("IMG_0756", "pair_25"),
        ("IMG_0757", "pair_26"), ("IMG_0758", "pair_26"), ("IMG_0759", "pair_26"), ("IMG_0760", "pair_26"),
        ("IMG_0761", "pair_27"), ("IMG_0762", "pair_27"), ("IMG_0763", "pair_27"), ("IMG_0764", "pair_27"),
        ("IMG_0775", "pair_28"), ("IMG_0776", "pair_28"), ("IMG_0777", "pair_28"), ("IMG_0778", "pair_28"),
        ("IMG_0779", "pair_29"), ("IMG_0780", "pair_29"), ("IMG_0781", "pair_29"), ("IMG_0782", "pair_29"),
        ("IMG_0784", "pair_30"), ("IMG_0785", "pair_30"), ("IMG_0786", "pair_30"), ("IMG_0787", "pair_30"),
        ("IMG_0788", "pair_31"), ("IMG_0789", "pair_31"), ("IMG_0790", "pair_31"), ("IMG_0791", "pair_31"),
        ("IMG_0792", "pair_32"), ("IMG_0793", "pair_32"), ("IMG_0794", "pair_32"), ("IMG_0795", "pair_32"),
        ("IMG_0796", "pair_33"), ("IMG_0797", "pair_33"), ("IMG_0798", "pair_33"), ("IMG_0799", "pair_33"),
        ("IMG_0800", "pair_34"), ("IMG_0801", "pair_34"), ("IMG_0802", "pair_34"), ("IMG_0803", "pair_34"),
        ("IMG_0804", "pair_35"), ("IMG_0805", "pair_35"), ("IMG_0806", "pair_35"), ("IMG_0807", "pair_35"),
        ("IMG_0808", "pair_36"), ("IMG_0809", "pair_36"), ("IMG_0810", "pair_36"), ("IMG_0811", "pair_36"),
        ("IMG_0812", "pair_37"), ("IMG_0813", "pair_37"), ("IMG_0814", "pair_37"), ("IMG_0815", "pair_37"),
        ("IMG_0816", "pair_38"), ("IMG_0817", "pair_38"), ("IMG_0818", "pair_38"), ("IMG_0819", "pair_38"),
        ("IMG_0820", "pair_39"), ("IMG_0821", "pair_39"), ("IMG_0822", "pair_39"), ("IMG_0823", "pair_39"),
        ("IMG_0824", "pair_40"), ("IMG_0825", "pair_40"), ("IMG_0826", "pair_40"), ("IMG_0827", "pair_40"),
        ("IMG_0828", "pair_41"), ("IMG_0829", "pair_41"), ("IMG_0830", "pair_41"), ("IMG_0831", "pair_41"),
        ("IMG_0832", "pair_42"), ("IMG_0833", "pair_42"), ("IMG_0834", "pair_42"), ("IMG_0835", "pair_42"),
        ("IMG_0836", "pair_43"), ("IMG_0837", "pair_43"), ("IMG_0838", "pair_43"), ("IMG_0839", "pair_43"),
        ("IMG_0840", "pair_44"), ("IMG_0841", "pair_44"), ("IMG_0842", "pair_44"), ("IMG_0843", "pair_44"),
        ("IMG_0844", "pair_45"), ("IMG_0845", "pair_45"), ("IMG_0846", "pair_45"), ("IMG_0847", "pair_45"),
        ("IMG_0848", "pair_46"), ("IMG_0849", "pair_46"), ("IMG_0850", "pair_46"), ("IMG_0851", "pair_46"),
        ("IMG_0852", "pair_47"), ("IMG_0853", "pair_47"), ("IMG_0854", "pair_47"), ("IMG_0855", "pair_47"),
        ("IMG_0856", "pair_48"), ("IMG_0857", "pair_48"), ("IMG_0858", "pair_48"), ("IMG_0859", "pair_48"),
        ("IMG_0860", "pair_49"), ("IMG_0861", "pair_49"), ("IMG_0862", "pair_49"), ("IMG_0863", "pair_49"),
        ("IMG_0864", "pair_50"), ("IMG_0865", "pair_50"), ("IMG_0866", "pair_50"), ("IMG_0867", "pair_50")
    ]
    
    static func cardsFromRandomGroups(_ groupCount: Int, cardsPerGroup: Int) -> [(imageName: String, pairID: String)] {

        let allPairIDs = Array(Set(myCards.map { $0.pairID })).shuffled()
        let selectedPairIDs = Array(allPairIDs.prefix(groupCount))
        
        var result: [(imageName: String, pairID: String)] = []
        for pairID in selectedPairIDs {
            let groupCards = myCards.filter { $0.pairID == pairID }
            result += Array(groupCards.shuffled().prefix(cardsPerGroup))
        }
        return result.shuffled()
    }
    
    static let levelCategories: [(items: [(imageName: String, pairID: String)], matchCount: Int, columns: Int)] = {
        
        var categories: [(items: [(imageName: String, pairID: String)], matchCount: Int, columns: Int)] = []
        let levelConfigs: [(groupCount: Int, cardsPerGroup: Int, matchCount: Int, columns: Int, repeatCount: Int)] = [
            // 2
            (2, 2, 2, 2, 4),
            (4, 2, 2, 3, 4),
            (6, 2, 2, 3, 4),
            (8, 2, 2, 4, 4),
            (10, 2, 2, 4, 4),
            
            // 3
            (3, 3, 3, 3, 5),
            (4, 3, 3, 3, 5),
            (5, 3, 3, 4, 5),
            (6, 3, 3, 4, 5),
            (7, 3, 3, 4, 5),
            (8, 3, 3, 5, 5),
            (10, 3, 3, 5, 5),
            
            // 4
            (4, 4, 4, 4, 6),
            (5, 4, 4, 4, 6),
            (6, 4, 4, 5, 6),
            (7, 4, 4, 5, 6),
            (9, 4, 4, 6, 6),
            (10, 4, 4, 6, 6),
            (12, 4, 4, 6, 58),
        ]
        
        for config in levelConfigs {
            for _ in 0..<config.repeatCount {
                categories.append((
                    items: cardsFromRandomGroups(config.groupCount, cardsPerGroup: config.cardsPerGroup),
                    matchCount: config.matchCount,
                    columns: config.columns
                ))
            }
        }
        
        return categories
    }()
}
