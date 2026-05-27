import SwiftUI

struct ContentView: View {
    @State private var showGame = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    VStack(spacing: 10) {
                        Text("🧩")
                            .font(.system(size: 80))
                        Text("Найди пару")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.white)
                        Text("Тренируй память!")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    VStack(spacing: 15) {
                        Text("📋 Уровни:")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        showGame = true
                    }) {
                        HStack {
                            Text("🎮 Начать игру")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.green)
                                .shadow(color: .green.opacity(0.5), radius: 10, x: 0, y: 5)
                        )
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
            }
            .navigationDestination(isPresented: $showGame) {
                GameView()
            }
        }
    }
}
