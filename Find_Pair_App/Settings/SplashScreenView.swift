import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var rotation = 0.0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                // Твой градиентный фон
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.purple.opacity(0.8)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Твой логотип с анимацией
                    Text("🧩")
                        .font(.system(size: 100))
                        .rotationEffect(.degrees(rotation))
                        .scaleEffect(size)
                        .animation(.easeIn(duration: 1.5), value: rotation)
                    
                    Text("Найди пару")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(opacity)
                    
                    Text("Тренируй память!")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(opacity)
                    
                    // Индикатор загрузки
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding(.top, 30)
                        .opacity(opacity)
                }
                .onAppear {
                    // Анимация появления
                    withAnimation(.easeIn(duration: 1.2)) {
                        size = 1.0
                        opacity = 1.0
                        rotation = 360
                    }
                }
            }
            .onAppear {
                // Задержка перед переходом на главный экран
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isActive = true
                    }
                }
            }
        }
    }
}
