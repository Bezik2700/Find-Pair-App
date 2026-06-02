import SwiftUI

struct TopGameBar: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                        }
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    }
                    Text("")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                VStack(spacing: 5){
                    Text("Уровень \(viewModel.currentLevel)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    if viewModel.timeLimit > 0 {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(viewModel.timeRemaining > 0 ? .white : .red)
                            Text("\(viewModel.formatTime(viewModel.timeRemaining))")
                                    .font(.title3)
                                    .foregroundColor(viewModel.timeRemaining > 10 ? .white : .red)
                            
                            if viewModel.isTimeUp {
                                Text("Время вышло!")
                                    .font(.title3)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    if viewModel.clickLimit > 0 {
                        HStack {
                            Image(systemName: "hand.tap.fill")
                                .foregroundColor(viewModel.clicksRemaining > 0 ? .white : .red)
                            Text("\(viewModel.clicksRemaining)/\(viewModel.clickLimit)")
                                .font(.title3)
                                .foregroundColor(viewModel.clicksRemaining > 0 ? .white : .red)
                            
                            if viewModel.isClickLimitExceeded {
                                Text("Лимит превышен!")
                                    .font(.title3)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        viewModel.showHint()
                    }) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 25))
                                .foregroundColor(
                                    viewModel.currentHints > 0
                                        ? Color.yellow.opacity(0.8)
                                        : Color.black.opacity(0.5)
                                )
                        }
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    }
                    .disabled(
                        viewModel.currentHints == 0 ||
                        viewModel.isClickLimitExceeded ||
                        viewModel.isTimeUp
                    )
                    
                    Text("\(viewModel.currentHints)")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            
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
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(15)
        .padding(.horizontal, 4)
        .padding(.vertical, 6)
        .frame(height: 120)
        .frame(maxWidth: .infinity)
    }
}
