import SwiftUI

struct GameMenuButtonStyle: ButtonStyle {
    let gradientColors: [Color]
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                LinearGradient(
                    colors: configuration.isPressed ? gradientColors.map { $0.opacity(0.8) } : gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: gradientColors.first?.opacity(configuration.isPressed ? 0.2 : 0.4) ?? .black,
                    radius: configuration.isPressed ? 5 : 15, x: 0, y: configuration.isPressed ? 3 : 8)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0) // Эффект плавного физического нажатия
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct SettingsIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 64, height: 64)
            .background(
                LinearGradient(
                    colors: configuration.isPressed ? [.gray.opacity(0.6), .black.opacity(0.8)] : [.green, .red],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: .purple.opacity(configuration.isPressed ? 0.2 : 0.4),
                    radius: configuration.isPressed ? 4 : 12, x: 0, y: configuration.isPressed ? 2 : 6)
            .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? 45 : 0))
            .animation(.spring(response: 0.25, dampingFraction: 0.5), value: configuration.isPressed)
    }
}
