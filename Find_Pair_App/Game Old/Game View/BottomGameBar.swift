import SwiftUI

struct BottomGameBar: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.resetProgress()
            }) {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Сброс")
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.red.opacity(0.8))
                .cornerRadius(10)
            }
            
            Button(action: {
                withAnimation {
                    viewModel.setupLevel()
                }
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Заново")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color.orange.opacity(0.8))
                .cornerRadius(12)
            }
            
            Button(action: {
                withAnimation {
                    viewModel.addHint()
                }
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("add hints")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color.orange.opacity(0.8))
                .cornerRadius(12)
            }
        }
        .frame(height: 100) // Фиксированная высота
        .frame(maxWidth: .infinity) // Растягиваем на всю ширину
        .background(Color.black.opacity(0.3)) // Затемнённый фон
        .cornerRadius(15)
        .padding(.horizontal)
    }
}


