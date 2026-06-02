import SwiftUI
import YandexMobileAds

@main
struct Find_Pair_AppApp: App {
    
    init() {
        Task {
            await YandexAds.initializeSDK()
            YandexRewardedManager.shared.loadAd()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
