import SwiftUI

struct GameRules: View {
    private let cardSize: CGFloat = 150
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Rules_game")
                .foregroundColor(.white)
                .padding(.top, 10)
                .font(.system(size: 28))
                .fontWeight(.bold)
            
            Text("click_text_1")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.red)
                    .frame(width: cardSize, height: cardSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 4)
                    )
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: cardSize, height: cardSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 4)
                    )
                    .overlay(
                        Text("?")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
            
            Text("click_text_2")
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 4)
                        )
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.green)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
                .frame(width: cardSize, height: cardSize)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 4)
                        )
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.green)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
                .frame(width: cardSize, height: cardSize)
            }
            
            Text("click_text_3")
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack (spacing: 50) {
                HStack(spacing: 4) {
                    ForEach(0..<5, id: \.self) { index in
                        Circle()
                            .fill(index < 3 ? Color.green : Color.gray.opacity(0.5))
                            .frame(width: 12, height: 12)
                    }
                }
                VStack {
                    Button(action: {  }) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.yellow.opacity(0.8))
                    }
                    .disabled(false)
                    
                    Text("10")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            
            Text("click_text_4")
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 15) {
                Image("IMG_0690")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardSize, height: cardSize)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Image("IMG_0691")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardSize, height: cardSize)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text("click_text_5")
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("description_1")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.15))
                .cornerRadius(20)
            
            Text("click_text_6")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
        }
        .padding()
    }
}
