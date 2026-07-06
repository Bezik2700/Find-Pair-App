import SwiftUI

struct GameSettings: View {
    
    @AppStorage("isMusicEnabled") private var isMusicEnabled = true
    @AppStorage("isSoundEnabled") private var isSoundEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme = "game_fon_1"
    
    let imageNames: [String] = ["game_fon_1", "game_fon_2", "game_fon_3", "game_fon_4", "game_fon_5", "game_fon_6", "game_fon_7", "game_fon_8", "game_fon_9"]
    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        ZStack {
            
            Image(selectedTheme)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .blur(radius: 10)
                .animation(.easeInOut(duration: 0.5), value: selectedTheme)
            
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                
                    VStack(spacing: 15) {
                        Toggle(isOn: $isMusicEnabled) {
                            Text("game_music")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .tint(.green)
                        .onChange(of: isMusicEnabled) { _, enabled in
                            SoundManager.shared.playMultiSound()
                            if enabled {
                                SoundManager.shared.playBackgroundMusic("fon_music")
                            } else {
                                SoundManager.shared.stopBackgroundMusic()
                            }
                        }
                        .padding()
                        .background(isMusicEnabled ? .green.opacity(0.25) : .red.opacity(0.25))
                        .cornerRadius(15)
                        
                        Toggle(isOn: $isSoundEnabled) {
                            Text("game_sound")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .tint(.green)
                        .onChange(of: isSoundEnabled) { _, newValue in
                            SoundManager.shared.playMultiSound()
                        }
                        .padding()
                        .background(isSoundEnabled ? .green.opacity(0.25) : .red.opacity(0.25))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal, 24)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(imageNames, id: \.self) { imageName in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: selectedTheme == imageName ? 110 : 95,
                                           height: selectedTheme == imageName ? 110 : 95)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(
                                                selectedTheme == imageName ? Color.green : Color.white,
                                                lineWidth: selectedTheme == imageName ? 3 : 2
                                            )
                                    )
                                
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: selectedTheme == imageName ? 100 : 85,
                                           height: selectedTheme == imageName ? 100 : 85)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedTheme)
                            .onTapGesture {
                                SoundManager.shared.playMultiSound()
                                selectedTheme = imageName
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    Text("About Game")
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .font(.system(size: 28))
                        .fontWeight(.bold)

                }
                .padding(.vertical, 20)
            }
        }
    }
}
