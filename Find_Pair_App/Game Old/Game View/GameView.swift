import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                TopGameBar(viewModel: viewModel)
                
                Spacer()
                
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 8),
                                  count: viewModel.currentLevelData.columns),
                    spacing: 8
                ) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, viewModel: viewModel)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    viewModel.selectCard(card)
                                }
                            }
                    }
                }
                .padding()
                
                Spacer()
                
                BottomGameBar(viewModel: viewModel)
            }
        }
        .onDisappear {
            viewModel.stopTimer()
        }
        .navigationBarHidden(true)
    }
}
