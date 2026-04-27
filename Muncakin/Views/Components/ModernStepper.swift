// Views/Components/ModernStepper.swift

import SwiftUI

struct ModernStepper: View {
    @Binding var value: Int
    var title: String
    var range: ClosedRange<Int>

    private var atMin: Bool { value <= range.lowerBound }
    private var atMax: Bool { value >= range.upperBound }

    var body: some View {
        HStack {
            Text(title)
                .font(.body)

            Spacer()

            HStack(spacing: 0) {
                Button {
                    if !atMin { value -= 1 }
                } label: {
                    Image(systemName: "minus")
                        .font(.body.weight(.semibold))
                        .frame(width: 36, height: 36)
                        .foregroundStyle(Color.muncakinPrimary)
                        .opacity(atMin ? 0.3 : 1)
                }
                .disabled(atMin)

                Text("\(value)")
                    .font(.body)
                    .monospacedDigit()
                    .frame(minWidth: 32)

                Button {
                    if !atMax { value += 1 }
                } label: {
                    Image(systemName: "plus")
                        .font(.body.weight(.semibold))
                        .frame(width: 36, height: 36)
                        .foregroundStyle(Color.muncakinPrimary)
                        .opacity(atMax ? 0.3 : 1)
                }
                .disabled(atMax)
            }
            .background(.secondary.opacity(0.12), in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var count = 1
    ModernStepper(value: $count, title: "Jumlah Orang", range: 1...20)
        .padding()
}
