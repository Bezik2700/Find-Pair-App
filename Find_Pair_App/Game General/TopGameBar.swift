import SwiftUI

struct TopGameBar<VM: TopBarViewModelProtocol>: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: VM
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                VStack(spacing: 5) {
                    Text("level \(viewModel.currentLevelDisplay)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack {
                        if viewModel.timeLimit > 0 {
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(viewModel.timeRemaining > 0 ? .white : .red)
                                Text("\(viewModel.formatTime(viewModel.timeRemaining))")
                                    .font(.title3)
                                    .foregroundColor(viewModel.timeRemaining > 10 ? .white : .red)
                            }
                            .padding(.horizontal)
                        }
                        
                        if viewModel.clickLimit > 0 {
                            HStack {
                                Image(systemName: "hand.tap.fill")
                                    .foregroundColor(viewModel.clicksRemaining > 0 ? .white : .red)
                                Text("\(viewModel.clicksRemaining)/\(viewModel.clickLimit)")
                                    .font(.title3)
                                    .foregroundColor(viewModel.clicksRemaining > 0 ? .white : .red)
                            }
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        if viewModel.currentHints > 0 {
                            SoundManager.shared.playHintSound()
                            viewModel.showHint()
                        }
                    }) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 25))
                            .foregroundColor(viewModel.currentHints > 0 ? .yellow.opacity(0.8) : .black.opacity(0.5))
                    }
                    .disabled(viewModel.currentHints == 0 || viewModel.isClickLimitExceeded || viewModel.isTimeUp)
                    
                    Text("\(viewModel.currentHints)")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            
            HStack(spacing: 4) {
                ForEach(0..<viewModel.totalPairs, id: \.self) { index in
                    Circle()
                        .fill(index < viewModel.matchedPairs ? Color.green : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(30)
        .padding(.horizontal)
        .frame(height: 100)
        .frame(maxWidth: .infinity)
    }
}
