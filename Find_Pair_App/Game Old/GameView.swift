import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @AppStorage("selectedTheme") private var selectedTheme = "test_1"
    
    var body: some View {
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
            
            HStack {
                if viewModel.isClickLimitExceeded || viewModel.isTimeUp {
                    Button(action: {
                        viewModel.restartLevel()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Попробовать снова")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 20)
                    }
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeInOut, value: viewModel.isClickLimitExceeded)
                    .animation(.easeInOut, value: viewModel.isTimeUp)
                }
                
                Button(action: {
                    viewModel.resetProgress()
                }) {
                    HStack {
                        Text("reset")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
            }
            
            BottomGameBar()
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
