import SwiftUI

struct DifficultyCardView: View {
    let card: DifficultyCard
    
    var body: some View {
        GeometryReader { geometry in
            
            let size = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                if card.isMatched {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 4)
                        )
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: size * 0.3, weight: .bold))
                        .foregroundColor(.green)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        
                } else if card.isFaceUp {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                        .overlay(
                            Image(card.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        )
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                        .overlay(
                            Text("?")
                                .font(.system(size: size * 0.35, weight: .bold))
                                .foregroundColor(.white)
                        )
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.3), value: card.isFaceUp)
        .animation(.easeInOut(duration: 0.3), value: card.isMatched)
    }
}
