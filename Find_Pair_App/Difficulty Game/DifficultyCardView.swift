import SwiftUI

struct DifficultyCardView: View {
    let card: DifficultyCard
    
    var body: some View {
        ZStack {
            if card.isMatched {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 2)
                    )
                    .overlay(
                        Text(card.emoji)
                            .font(.system(size: 40))
                    )
            } else if card.isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .overlay(
                        Text(card.emoji)
                            .font(.system(size: 40))
                    )
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .overlay(
                        Text("?")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 0 : 180),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5  // ← Добавляет глубину
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: card.isFaceUp)
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: card.isMatched)
    }
}
