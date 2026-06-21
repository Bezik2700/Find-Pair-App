import SwiftUI
import YandexMobileAds

struct YandexBanner: UIViewRepresentable {
    let adUnitId: String = "demo-banner-yandex"
    
    @MainActor
    class Coordinator: NSObject, BannerAdViewDelegate {
        func bannerAdViewDidLoad(_ bannerAdView: BannerAdView) {
            print("Яндекс Реклама: Баннер успешно загружен.")
        }

        func bannerAdViewDidFailLoading(_ bannerAdView: BannerAdView, error: Error) {
            print("Яндекс Реклама: Ошибка загрузки — \(error.localizedDescription)")
        }

        func bannerAdViewDidClick(_ bannerAdView: BannerAdView) {
            print("Яндекс Реклама: Зафиксирован клик по баннеру.")
        }

        func bannerAdViewWillPresentScreen(_ bannerAdView: BannerAdView) {
            print("Яндекс Реклама: Открытие окна поверх приложения.")
        }

        func bannerAdViewDidDismissScreen(_ bannerAdView: BannerAdView) {
            print("Яндекс Реклама: Пользователь вернулся в приложение.")
        }

        func bannerAdView(_ bannerAdView: BannerAdView, didTrackImpression impressionData: ImpressionData?) {
            print("Яндекс Реклама: Показ баннера успешно засчитан.")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        
        // СОВРЕМЕННЫЙ СПОСОБ (iOS 26+): Получаем ширину экрана через контекст Window Scene
        // Если сцена еще не привязана, безопасно берем стандартную ширину устройства
        let windowWidth: CGFloat
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowWidth = windowScene.screen.bounds.width - 24
        } else {
            windowWidth = 350 // Дефолтное значение-заглушка до отрисовки интерфейса
        }
        
        // Передаем корректную ширину из контекста сцены
        let adSize = BannerAdSize.sticky(containerWidth: windowWidth)
        
        let bannerView = BannerAdView(adSize: adSize)
        bannerView.delegate = context.coordinator
        
        // Задаем размеры отображения
        bannerView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: 100)
        containerView.addSubview(bannerView)
        
        // Загрузка
        let request = AdRequest(adUnitID: adUnitId)
        bannerView.loadAd(with: request)
        
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Оставляем пустым
    }
}
