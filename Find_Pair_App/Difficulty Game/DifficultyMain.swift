import SwiftUI
import Combine

struct DifficultyMain: View {
    @StateObject private var viewModel = DifficultyViewModel()
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
                
                TopDifficultyBar(viewModel: DifficultyViewModel())
                
                Spacer()
                
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 8),
                                  count: viewModel.columns),
                    spacing: 8
                ) {
                    ForEach(viewModel.cards) { card in
                        DifficultyCardView(card: card)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    viewModel.selectCard(card)
                                }
                            }
                    }
                }
                .padding()
                
                Spacer()
                
                BottomDifficultyBar(viewModel: DifficultyViewModel())
            }
        }
        .navigationBarHidden(true)
    }
}
