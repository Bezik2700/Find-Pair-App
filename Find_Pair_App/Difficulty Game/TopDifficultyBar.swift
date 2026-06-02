import SwiftUI

struct TopDifficultyBar: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: DifficultyViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                // Кнопка назад
                VStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 5)
                    
                    Text("")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Центральная информация
                VStack(spacing: 5) {
                    Text("Уровень \(viewModel.currentLevel)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Показываем категории для поиска
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(viewModel.currentCategories, id: \.self) { category in
                                Text(viewModel.categoryName(for: category))
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .frame(height: 30)
                    
                    Text("Найди пары по категориям")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Кнопка перезапуска (заменяет подсказку)
                VStack {
                    Button(action: {
                        viewModel.restartLevel()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 5)
                    
                    Text("")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 4)
            
            // Кружочки прогресса
            HStack(spacing: 8) {
                ForEach(0..<viewModel.totalPairs, id: \.self) { index in
                    Circle()
                        .fill(index < viewModel.matchedPairs ? Color.green : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.6), lineWidth: 1)
                        )
                        .animation(.easeInOut(duration: 0.3), value: viewModel.matchedPairs)
                }
                
                Spacer()
                
                Text("Ходы: \(viewModel.moves)")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 10)
        .background(Color.black.opacity(0.5))
        .cornerRadius(15)
        .padding(.horizontal, 4)
        .padding(.vertical, 6)
        .frame(height: 120)
        .frame(maxWidth: .infinity)
    }
}
