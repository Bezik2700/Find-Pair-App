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
                .onAppear {
                    SoundManager.shared.playBackgroundMusic("fon_music")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    SoundManager.shared.pauseBackgroundMusic()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    SoundManager.shared.resumeBackgroundMusic()
            }
        }
    }
}
