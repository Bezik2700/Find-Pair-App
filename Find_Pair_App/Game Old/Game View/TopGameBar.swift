import SwiftUI

struct TopGameBar: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        // Информационная панель
        VStack(spacing: 12) {
            // Уровень и ходы
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("Меню")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(12)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.showHint()
                }) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.yellow)
                    }
                    .disabled(viewModel.currentHints == 0)
                    .foregroundColor(.white)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(
                        viewModel.currentHints > 0
                            ? Color.blue.opacity(0.8)
                            : Color.gray.opacity(0.5)
                    )
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            
            HStack {
                Label("Уровень \(viewModel.currentLevel)", systemImage: "flag.fill")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Label("Подсказки: \(viewModel.currentHints)", systemImage: "hand.tap.fill")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            
            // Кружочки прогресса
            HStack(spacing: 8) {
                Text("Пары:")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                
                ForEach(0..<viewModel.totalPairs, id: \.self) { index in
                    Circle()
                        .fill(index < viewModel.matchedPairs ? Color.green : Color.gray.opacity(0.5))
                        .frame(width: 10, height: 10)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.6), lineWidth: 1)
                        )
                        .animation(.easeInOut(duration: 0.3), value: viewModel.matchedPairs)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(15)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(height: 120) // Фиксированная высота всей панели
        .frame(maxWidth: .infinity)
    }
}

