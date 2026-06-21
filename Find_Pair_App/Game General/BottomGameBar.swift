import SwiftUI

struct BottomGameBar: View {

    var body: some View {
        HStack {
            YandexBanner()
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.3))
        .cornerRadius(30)
        .padding(.horizontal)
    }
}


