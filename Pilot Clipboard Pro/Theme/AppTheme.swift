import SwiftUI

enum AppTheme {
    // MARK: - Colors
    static let background = Color(hex: 0x000000)
    static let cyan = Color(hex: 0x00E5CC)
    static let amber = Color(hex: 0xCC8800)
    static let red = Color(hex: 0xFF3333)
    static let white = Color.white
    static let lightGray = Color(hex: 0xAAAAAA)
    static let darkGray = Color(hex: 0x1A1A1A)
    static let cardBackground = Color(hex: 0x111111)

    // MARK: - Fonts
    static let headingFont = Font.system(size: 18, weight: .bold, design: .default)
    static let subheadingFont = Font.system(size: 15, weight: .semibold, design: .default)
    static let bodyFont = Font.system(size: 14, weight: .regular, design: .default)
    static let labelFont = Font.system(size: 12, weight: .medium, design: .default)
    static let captionFont = Font.system(size: 11, weight: .regular, design: .default)
    static let tabFont = Font.system(size: 10, weight: .bold, design: .default)

    // MARK: - Dimensions
    static let sidebarWidth: CGFloat = 250
    static let tabBarHeight: CGFloat = 50
    static let cornerRadius: CGFloat = 8
    static let iconSize: CGFloat = 24
}

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
