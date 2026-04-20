// Views/SplashView.swift

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image("img_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 260)

                VStack(spacing: 8) {
                    Text("Muncakin")
                        .font(.serifTitle(.largeTitle, weight: .bold))

                    Text("Lebih baik sakit kaki daripada sakit hati")
                        .font(.system(.subheadline, design: .serif))
                        .italic(true)
                        .foregroundStyle(.muncakinSecondary)
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
