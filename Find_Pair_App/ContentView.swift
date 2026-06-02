import SwiftUI
import YandexMobileAds
import UIKit
import Combine

struct ContentView: View {
    
    let rewardedManager = YandexRewardedManager.shared
    
    @State private var showGame = false
    @State private var showDifficultyGame = false
    
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
                    
                    Button(action: {
                        showGame = true
                    }) {
                        HStack {
                            Text("Начать игру")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showDifficultyGame = true
                    }) {
                        HStack {
                            Text("Начать трудную игру")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                                    // Вызываем показ рекламы
                                    rewardedManager.showAd {
                                        // ЭТОТ БЛОК КОДА СРАБОТАЕТ СТРОГО ПОСЛЕ УСПЕШНОГО ПРОСМОТРА:
                                        // hintsCount += 1 // Выдаем награду игроку
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "play.rectangle.fill")
                                        Text(rewardedManager.isAdReady ? "Подсказка за рекламу (+1)" : "Загрузка видео...")
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
                    
                    YandexBanner()
                        .frame(height: 100)
                        .background(Color(.systemBackground))
                        .padding(.horizontal, 12) 
                        .padding(.bottom, 20)
                    
                }
                .padding(.top, 100)
            }
            .navigationDestination(isPresented: $showGame) {
                GameView()
            }
            .navigationDestination(isPresented: $showDifficultyGame) {
                DifficultyMain()
            }
        }
    }
}
