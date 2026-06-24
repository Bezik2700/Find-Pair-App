import SwiftUI

struct GameSettings: View {
    
    @AppStorage("isMusicEnabled") private var isMusicEnabled = true
    @AppStorage("isSoundEnabled") private var isSoundEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme = "test_1"
    
    let imageNames: [String] = ["test_1", "test_2", "test_3", "test_4", "test_5", "test_6", "test_7", "test_8", "test_9"]
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
            
            VStack(spacing: 30) {
                Text("game_background")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack(spacing: 15) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(imageNames, id: \.self) { imageName in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: selectedTheme == imageName ? 120 : 100, height: selectedTheme == imageName ? 120 : 100)
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
                                    .frame(width: selectedTheme == imageName ? 110 : 90, height: selectedTheme == imageName ? 110 : 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedTheme = imageName
                                }
                            }
                        }
                    }
                }
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        Toggle(isOn: $isMusicEnabled) {
                            HStack {
                                Image(systemName: "music.note")
                                Text("game_music")
                            }
                            .foregroundColor(.white)
                        }
                        .tint(.green)
                        .onChange(of: isMusicEnabled) { _, enabled in
                            if enabled {
                                SoundManager.shared.playBackgroundMusic("fon_sound")
                            } else {
                                SoundManager.shared.stopBackgroundMusic()
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    
                    VStack(spacing: 15) {
                        Toggle(isOn: $isSoundEnabled) {
                            HStack {
                                Image(systemName: "speaker.wave.2")
                                Text("game_sound")
                            }
                            .foregroundColor(.white)
                        }
                        .tint(.green)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    
                    Spacer()
                }
            }
        }
    }
}

