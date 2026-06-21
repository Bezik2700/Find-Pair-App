import SwiftUI
import UIKit
import YandexMobileAds

@Observable
@MainActor
final class YandexRewardedManager: NSObject {
    
    // Синглтон для глобального доступа из SwiftUI
    static let shared = YandexRewardedManager()
    
    private let adUnitId = "demo-rewarded-yandex" // Тестовый ID
    private let rewardedAdLoader = RewardedAdLoader()
    private var rewardedAd: RewardedAd?
    
    // Флаг готовности для SwiftUI
    var isAdReady: Bool = false
    
    // Переменная для хранения действия награждения
    var onRewardEarned: (() -> Void)?
    
    private override init() {
        super.init()
    }
    
    // MARK: - Загрузка рекламы
    func loadAd() {
        print("Яндекс Видео: Начало загрузки...")
        let request = AdRequest(adUnitID: adUnitId)
        
        Task {
            do {
                let ad = try await rewardedAdLoader.loadAd(with: request)
                self.rewardedAd = ad
                self.rewardedAd?.delegate = self // Назначаем делегат
                self.isAdReady = true
                print("Яндекс Видео: Реклама успешно загружена.")
            } catch {
                self.isAdReady = false
                print("Яндекс Видео: Ошибка загрузки — \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Показ рекламы
    func showAd(onReward: @escaping () -> Void) {
        guard isAdReady, let rewardedAd = rewardedAd else { return }
        
        self.onRewardEarned = onReward
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rewardedAd.show(from: rootViewController)
        }
    }
}

// MARK: - Реализация делегата (Строго по предоставленному исходнику)
extension YandexRewardedManager: RewardedAdDelegate {
    
    // 1. Выдача награды
    func rewardedAd(_ rewardedAd: RewardedAd, didReward reward: any Reward) {
        print("Яндекс Видео: Показ успешно засчитан. Выдача награды.")
        onRewardEarned?()
    }
    
    // 2. Ошибка показа рекламы (Имя по objc: rewardedAd:didFailToShowWithError:)
    func rewardedAd(_ rewardedAd: RewardedAd, didFailToShow error: any Error) {
        print("Яндекс Видео: Ошибка показа рекламы — \(error.localizedDescription)")
        isAdReady = false
        loadAd()
    }
    
    // 3. Реклама была показана на экране
    func rewardedAdDidShow(_ rewardedAd: RewardedAd) {
        print("Яндекс Видео: Реклама отобразилась на экране.")
    }
    
    // 4. Реклама полностью закрыта пользователем
    func rewardedAdDidDismiss(_ rewardedAd: RewardedAd) {
        print("Яндекс Видео: Реклама закрыта пользователем.")
        isAdReady = false
        loadAd() // Предзагрузка следующего ролика
    }
    
    // 5. Зафиксирован клик по видеоролику
    func rewardedAdDidClick(_ rewardedAd: RewardedAd) {
        print("Яндекс Видео: Пользователь кликнул по рекламе.")
    }
    
    // 6. Зафиксирован показ / Аналитика (Имя по objc: rewardedAd:didTrackImpressionWithData:)
    func rewardedAd(_ rewardedAd: RewardedAd, didTrackImpression impressionData: (any ImpressionData)?) {
        print("Яндекс Видео: Импрессия успешно засчитана.")
    }
}

