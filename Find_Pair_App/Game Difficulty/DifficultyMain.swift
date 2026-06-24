import SwiftUI
import Combine

struct DifficultyMain: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var difficultViewModel = DifficultyViewModel()
    @AppStorage("selectedTheme") private var selectedTheme = "test_1"
    
    var body: some View {
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
                Text("reset")
                    .font(.title2)
                    .fontWeight(.semibold)
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
