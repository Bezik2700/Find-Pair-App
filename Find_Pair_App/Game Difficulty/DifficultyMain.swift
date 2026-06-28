import SwiftUI
import Combine

struct DifficultyMain: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var difficultViewModel = DifficultyViewModel()
    @AppStorage("selectedTheme") private var selectedTheme = "test_1"
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 15) {
                
                TopGameBar(viewModel: difficultViewModel)
                
                Spacer()
                
                // Что ищем
                Text(difficultViewModel.levelDescription)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(20)
                
                // Сетка карточек
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 8),
                                  count: difficultViewModel.columns),
                    spacing: 8
                ) {
                    ForEach(difficultViewModel.cards) { card in
                        DifficultyCardView(card: card)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    difficultViewModel.selectCard(card)
                                }
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Кнопки
                HStack(spacing: 20) {
                    // Restart — только при проигрыше
                    if difficultViewModel.isClickLimitExceeded || difficultViewModel.isTimeUp {
                        Button(action: {
                            withAnimation {
                                difficultViewModel.restartLevel()
                            }
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.clockwise")
                                Text("Попробовать снова")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(Color.orange)
                            .cornerRadius(15)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                    
                    // Reset
                    Button(action: {
                        difficultViewModel.resetProgress()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "trash")
                            Text("Сброс")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(15)
                    }
                }
                .animation(.easeInOut, value: difficultViewModel.isClickLimitExceeded)
                .animation(.easeInOut, value: difficultViewModel.isTimeUp)
                
                BottomGameBar()
            }
        }
        .navigationBarHidden(true)
        .background(
            ZStack {
                Image(selectedTheme)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 10)
                
                Color.black.opacity(0.5)
            }
            .ignoresSafeArea()
        )
    }
}
