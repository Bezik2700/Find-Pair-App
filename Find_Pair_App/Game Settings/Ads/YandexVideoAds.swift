import SwiftUI
import UIKit
import YandexMobileAds

@Observable
@MainActor
final class YandexRewardedManager: NSObject {
    
    static let shared = YandexRewardedManager()
    private let adUnitId = "demo-rewarded-yandex"
    private let rewardedAdLoader = RewardedAdLoader()
    private var rewardedAd: RewardedAd?
    
    var isAdReady: Bool = false
    var onRewardEarned: (() -> Void)?
    
    private override init() {
        super.init()
    }
    
    func loadAd() {
        print("Ads: start downloading...")
        let request = AdRequest(adUnitID: adUnitId)
        
        Task {
            do {
                let ad = try await rewardedAdLoader.loadAd(with: request)
                self.rewardedAd = ad
                self.rewardedAd?.delegate = self
                self.isAdReady = true
                print("Ads: Rewarded download")
            } catch {
                self.isAdReady = false
                print("Ads: Error downloading — \(error.localizedDescription)")
            }
        }
    }
    
    func showAd(onReward: @escaping () -> Void) {
        guard isAdReady, let rewardedAd = rewardedAd else { return }
        
        self.onRewardEarned = onReward
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rewardedAd.show(from: rootViewController)
        }
    }
}

extension YandexRewardedManager: RewardedAdDelegate {
    
    func rewardedAd(_ rewardedAd: RewardedAd, didReward reward: any Reward) {
        print("Ads: + plus user hints")
        onRewardEarned?()
    }
    
    func rewardedAd(_ rewardedAd: RewardedAd, didFailToShow error: any Error) {
        print("Ads: error ads — \(error.localizedDescription)")
        isAdReady = false
        loadAd()
    }
    
    func rewardedAdDidShow(_ rewardedAd: RewardedAd) {
        print("Ads: on screen")
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: RewardedAd) {
        print("Ads: user close")
        isAdReady = false
        loadAd()
    }
    
    func rewardedAdDidClick(_ rewardedAd: RewardedAd) {
        print("Ads: user click")
    }
    
    func rewardedAd(_ rewardedAd: RewardedAd, didTrackImpression impressionData: (any ImpressionData)?) {
        print("Ads: add impression")
    }
}

