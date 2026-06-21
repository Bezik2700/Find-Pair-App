import SwiftUI
import Combine

struct DifficultyMain: View {
    @StateObject private var difficultViewModel = DifficultyViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                TopGameBar(viewModel: difficultViewModel)
                
                Spacer()
                
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
                .padding()
                
                Spacer()
                
                Button(action: {
                    difficultViewModel.resetProgress()
                }) {
                    HStack {
                        Text("reset")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
                
                
                BottomGameBar()
            }
        }
        .navigationBarHidden(true)
    }
}
