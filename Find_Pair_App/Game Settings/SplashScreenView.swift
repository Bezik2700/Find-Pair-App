import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var progress: Double = 0
    @State private var aboutOffset: CGFloat = 100
    @State private var aboutOpacity: Double = 0
    @State private var randomText = ""
    let aboutTexts = [
        NSLocalizedString("about_text_1", comment: ""),
        NSLocalizedString("about_text_2", comment: ""),
        NSLocalizedString("about_text_3", comment: ""),
        NSLocalizedString("about_text_4", comment: ""),
        NSLocalizedString("about_text_5", comment: ""),
        NSLocalizedString("about_text_6", comment: ""),
        NSLocalizedString("about_text_7", comment: ""),
        NSLocalizedString("about_text_8", comment: ""),
        NSLocalizedString("about_text_9", comment: ""),
        NSLocalizedString("about_text_10", comment: "")
    ]
    
    let title = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ZStack {
                        Image("app_icon")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .cornerRadius(25)
                            .grayscale(1.0)
                        
                        Image("app_icon")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .cornerRadius(25)
                            .mask(
                                Circle()
                                    .scaleEffect(progress * 1.5)
                            )
                    }
                    HStack(spacing: 2) {
                        ForEach(Array(title.enumerated()), id: \.offset) { index, letter in
                            Text(String(letter))
                                .font(.system(size: 38, weight: .bold))
                                .foregroundColor(.white)
                                .blur(radius: progress > Double(index) / Double(title.count) ? 0 : 20)
                                .opacity(progress > Double(index) / Double(title.count) ? 1 : 0)
                                .animation(
                                    .easeOut(duration: 2.0)
                                    .delay(Double(index) * 0.08),
                                    value: progress
                                )
                        }
                    }
                    Text(randomText)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.gray)
                        .offset(y: aboutOffset)
                        .opacity(aboutOpacity)
                        .onAppear {
                            randomText = aboutTexts.randomElement() ?? ""
                            withAnimation(.interpolatingSpring(stiffness: 100, damping: 8).delay(0.3)) {
                                aboutOffset = 0
                                aboutOpacity = 1
                            }
                        }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0)) {
                    progress = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isActive = true
                }
            }
        }
    }
}
