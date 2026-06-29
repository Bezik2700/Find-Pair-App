import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var progress: Double = 0
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
                
                VStack(spacing: 30) {
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
                    HStack(spacing: 0) {
                        ForEach(Array(title.enumerated()), id: \.offset) { index, letter in
                            Text(String(letter))
                                .font(.system(size: 38, weight: .bold))
                                .foregroundColor(.white)
                                .opacity(progress > Double(index) / Double(title.count) ? 1 : 0)
                                .offset(x: progress > Double(index) / Double(title.count) ? 0 : 20)
                                .animation(.easeOut(duration: 2.5).delay(Double(index) * 0.05), value: progress)
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 2.5)) {
                    progress = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isActive = true
                }
            }
        }
    }
}
