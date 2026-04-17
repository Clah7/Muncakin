// Views/SplashView.swift

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.tint)

                Text("Muncakin")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Lebih baik sakit kaki daripada sakit hati")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    SplashView()
}
