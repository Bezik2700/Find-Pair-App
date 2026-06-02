import SwiftUI

struct BottomDifficultyBar: View {
    @ObservedObject var viewModel: DifficultyViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            // Кнопка сброса
            Button(action: {
                viewModel.restartLevel()
            }) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Заново")
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.orange.opacity(0.8))
                .cornerRadius(10)
            }
            
            // Кнопка следующего уровня (только если уровень пройден)
            if viewModel.isLevelComplete {
                Button(action: {
                    withAnimation {
                        viewModel.nextLevel()
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                        Text("Дальше")
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.green.opacity(0.8))
                    .cornerRadius(10)
                }
            }
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.3))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

