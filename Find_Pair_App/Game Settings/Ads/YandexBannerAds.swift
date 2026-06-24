import SwiftUI
import YandexMobileAds

struct YandexBanner: UIViewRepresentable {
    let adUnitId: String = "demo-banner-yandex"
    
    @MainActor
    class Coordinator: NSObject, BannerAdViewDelegate {
        func bannerAdViewDidLoad(_ bannerAdView: BannerAdView) {
            print("Ads: banner download")
        }

        func bannerAdViewDidFailLoading(_ bannerAdView: BannerAdView, error: Error) {
            print("Ads: error downloading — \(error.localizedDescription)")
        }

        func bannerAdViewDidClick(_ bannerAdView: BannerAdView) {
            print("Ads: banner click")
        }

        func bannerAdViewWillPresentScreen(_ bannerAdView: BannerAdView) {
            print("Ads: on up screen")
        }

        func bannerAdViewDidDismissScreen(_ bannerAdView: BannerAdView) {
            print("Ads: user in app")
        }

        func bannerAdView(_ bannerAdView: BannerAdView, didTrackImpression impressionData: ImpressionData?) {
            print("Ads: banner plus +")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        let windowWidth: CGFloat
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowWidth = windowScene.screen.bounds.width - 24
        } else {
            windowWidth = 350
        }
        
        let adSize = BannerAdSize.sticky(containerWidth: windowWidth)
        
        let bannerView = BannerAdView(adSize: adSize)
        bannerView.delegate = context.coordinator
        
        bannerView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: 100)
        containerView.addSubview(bannerView)
        
        let request = AdRequest(adUnitID: adUnitId)
        bannerView.loadAd(with: request)
        
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
