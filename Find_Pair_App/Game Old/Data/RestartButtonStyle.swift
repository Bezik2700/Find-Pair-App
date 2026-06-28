import SwiftUI

struct RestartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
                LinearGradient(
                    colors: configuration.isPressed ? [.init(red: 0.9, green: 0.3, blue: 0.1), .red] : [.orange, .init(red: 1.0, green: 0.3, blue: 0.1)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(22)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.white.opacity(0.35), lineWidth: 1.5)
            )
            .shadow(color: Color.red.opacity(configuration.isPressed ? 0.15 : 0.35),
                    radius: configuration.isPressed ? 4 : 12,
                    x: 0,
                    y: configuration.isPressed ? 2 : 6)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed) 
    }
}
