import SwiftUI
import YandexMobileAds

struct ContentView: View {
    
    let rewardedManager = YandexRewardedManager.shared
    
    @State private var showGame = false
    @State private var showGameSetiings = false
    @State private var showDifficultyGame = false
    
    @State private var addHints = 3
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @AppStorage("currentHints") private var currentHints = 0
    @AppStorage("difficultCurrentHints") private var difficultCurrentHints = 0
    @AppStorage("selectedTheme") private var selectedTheme = "game_fon_1"
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Image(selectedTheme)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            SoundManager.shared.playMultiSound()
                            showGameSetiings = true
                        }) {
                            Image(systemName: "gearshape.fill")
                        }
                        .buttonStyle(SettingsIconButtonStyle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        SoundManager.shared.playMultiSound()
                        showGame = true
                    }) {
                        Text("start_easy")
                    }
                    .buttonStyle(GameMenuButtonStyle(gradientColors: [.green, .init(red: 0.2, green: 0.8, blue: 0.5)]))
                    
                    Button(action: {
                        SoundManager.shared.playMultiSound()
                        showDifficultyGame = true
                    }) {
                        Text("start_difficult")
                    }
                    .buttonStyle(GameMenuButtonStyle(gradientColors: [.red, .orange]))
                    
                    Spacer()
                    
                    Button(action: {
                        SoundManager.shared.playMultiSound()
                        if rewardedManager.isAdReady {
                            rewardedManager.showAd {
                                currentHints += addHints
                                difficultCurrentHints += addHints
                                alertMessage = NSLocalizedString("add_hints", comment: "")
                                showAlert = true
                            }
                        } else {
                            alertMessage = NSLocalizedString("ad_not_ready", comment: "")
                            showAlert = true
                        }
                    }) {
                        HStack (spacing: 50) {
                            Image(systemName: "play.rectangle.fill")
                                .font(.system(size: 40))
                            VStack {
                                Text(NSLocalizedString("add_hints_button", comment: ""))
                                    .font(.system(size: 20))
                                Text(NSLocalizedString("add_hints_button_2", comment: ""))
                                    .font(.system(size: 12))
                                
                            }
                        }
                    }
                    .buttonStyle(GameMenuButtonStyle(gradientColors: [.green, .init(red: 0.3, green: 0.3, blue: 0.3)]))  
                }
                .padding(.horizontal, 48)
            }
            .alert("notification", isPresented: $showAlert) {
                Button("ok", role: .cancel) { }
            } message: {
                Text(LocalizedStringKey(alertMessage))
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
