// Utils/Theme.swift

import SwiftUI

// MARK: - Colors

extension Color {
    /// Forest Green — primary brand color (#2E8B57 light, #3DA870 dark)
    static let muncakinPrimary = Color(
        light: Color(red: 0.18, green: 0.545, blue: 0.341),
        dark: Color(red: 0.24, green: 0.66, blue: 0.44)
    )

    /// Slate Grey — secondary/muted information (#6B7280 light, #9CA3AF dark)
    static let muncakinSecondary = Color(
        light: Color(red: 0.42, green: 0.45, blue: 0.50),
        dark: Color(red: 0.61, green: 0.64, blue: 0.69)
    )

    /// Card surface — white in light, elevated gray in dark
    static let muncakinCardBackground = Color(
        light: Color(.systemBackground),
        dark: Color(.secondarySystemBackground)
    )

    /// Screen background — subtle gray in light, true black-ish in dark
    static let muncakinScreenBackground = Color(
        light: Color(.systemGroupedBackground),
        dark: Color(.systemBackground)
    )
}

private extension Color {
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark
                ? UIColor(dark)
                : UIColor(light)
        })
    }
}

// MARK: - Typography

extension Font {
    /// Serif font — ONLY for navigation titles and the splash screen title
    static func serifTitle(_ style: TextStyle = .largeTitle, weight: Weight = .bold) -> Font {
        .system(style, design: .serif, weight: weight)
    }
}

// MARK: - Navigation Bar Appearance

enum Theme {
    static let cardRadius: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let screenPadding: CGFloat = 16
    static let cardSpacing: CGFloat = 12

    static func configureNavigationBarAppearance() {
        let largeTitleAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: UIFontDescriptor.preferredFontDescriptor(
                withTextStyle: .largeTitle
            ).withDesign(.serif)!, size: 0),
        ]
        let inlineTitleAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: UIFontDescriptor.preferredFontDescriptor(
                withTextStyle: .headline
            ).withDesign(.serif)!, size: 0),
        ]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.largeTitleTextAttributes = largeTitleAttrs
        appearance.titleTextAttributes = inlineTitleAttrs

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - Floating Card Modifier

struct FloatingCard: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .padding(Theme.cardPadding)
            .background(Color.muncakinCardBackground)
            .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous))
            .overlay {
                if colorScheme == .dark {
                    RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
                }
            }
            .shadow(
                color: colorScheme == .light ? .black.opacity(0.05) : .clear,
                radius: 8, x: 0, y: 4
            )
    }
}

// MARK: - CTA Modifiers

struct PrimaryCTAStyle: ViewModifier {
    let isDisabled: Bool

    func body(content: Content) -> some View {
        content
            .font(.body.weight(.bold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(isDisabled ? Color.gray.opacity(0.4) : Color.muncakinPrimary)
            .clipShape(Capsule())
    }
}

struct DestructiveCTAStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.weight(.bold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(.red)
            .clipShape(Capsule())
    }
}

// MARK: - View Extensions

extension View {
    func floatingCard() -> some View {
        modifier(FloatingCard())
    }

    func primaryCTAStyle(isDisabled: Bool = false) -> some View {
        modifier(PrimaryCTAStyle(isDisabled: isDisabled))
    }

    func destructiveCTAStyle() -> some View {
        modifier(DestructiveCTAStyle())
    }
}

// MARK: - ShapeStyle Convenience

extension ShapeStyle where Self == Color {
    static var muncakinPrimary: Color { Color.muncakinPrimary }
    static var muncakinSecondary: Color { Color.muncakinSecondary }
    static var muncakinCardBackground: Color { Color.muncakinCardBackground }
    static var muncakinScreenBackground: Color { Color.muncakinScreenBackground }
}
