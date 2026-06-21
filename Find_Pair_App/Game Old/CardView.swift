import SwiftUI

struct CardView: View {
    let card: Card
    let viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            if card.isMatched {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.25))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 4)
                    )
            } else if card.isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        card.type == .emoji ? Color.white :
                        card.type == .number ? Color.black :
                        viewModel.getColorForCard(card)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .overlay(
                        Text(
                            card.type == .emoji ? card.content :
                            card.type == .number ? card.content :
                            ""
                        )
                            .font(.system(size: 35))
                    )
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
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
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.3), value: card.isFaceUp)
        .animation(.easeInOut(duration: 0.3), value: card.isMatched)
    }
}
