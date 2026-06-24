import SwiftUI
import YandexMobileAds

struct ContentView: View {
    
    let rewardedManager = YandexRewardedManager.shared
    
    @State private var showGame = false
    @State private var showGameSetiings = false
    @State private var showDifficultyGame = false
    
    @AppStorage("currentHints") private var currentHints = 0
    @AppStorage("selectedTheme") private var selectedTheme = "test_1"
    @AppStorage("difficultCurrentHints") private var difficultCurrentHints = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Image(selectedTheme)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                                
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    Button(action: {
                        showGame = true
                    }) {
                        HStack {
                            Text("Start easy")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Button(action: {
                        showGameSetiings = true
                    }) {
                        HStack {
                            Text("Settings")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Button(action: {
                        showDifficultyGame = true
                    }) {
                        HStack {
                            Text("Start difficult")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        rewardedManager.showAd {
                        currentHints += 5
                        difficultCurrentHints += 5
                        }
                    }) {
                        HStack {
                            Image(systemName: "play.rectangle.fill")
                            Text(rewardedManager.isAdReady ? "ads_bonus" : "loading...")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(rewardedManager.isAdReady ? Color.green : Color.gray)
                            .cornerRadius(12)
                        }
                    .disabled(!rewardedManager.isAdReady)
                    .padding(.horizontal, 30)
                    
                }
                .padding(.top, 100)
            }
            .navigationDestination(isPresented: $showGame) {
                GameView()
            }
            .navigationDestination(isPresented: $showDifficultyGame) {
                DifficultyMain()
            }
            .navigationDestination(isPresented: $showGameSetiings) {
                GameSettings()
            }
        }
    }
}

#Preview {
    // 1. Предварительно записываем тестовые данные в UserDefaults для @AppStorage
    let _ = {
        UserDefaults.standard.set(10, forKey: "currentHints")
        UserDefaults.standard.set("test_1", forKey: "selectedTheme")
        UserDefaults.standard.set(10, forKey: "difficultCurrentHints")
    }()
    
    // 2. Возвращаем сам экран без передачи внутренних параметров в инициализатор
    return ContentView()
}
