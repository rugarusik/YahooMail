import SwiftUI

enum DesignTokens {
    enum Colors {
        static let background = Color(hex: "#0F0F23")
        static let secondaryBackground = Color(hex: "#1A1A2E")
        static let tertiaryBackground = Color(hex: "#252541")
        static let primary = Color.white
        static let secondary = Color(hex: "#A0A0B8")
        static let accent = Color(hex: "#6001D2")
        static let separator = Color(hex: "#2A2A40")
    }

    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }

    enum Typography {
        static let title = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 17, weight: .semibold)
        static let body = Font.system(size: 15, weight: .regular)
        static let caption = Font.system(size: 13, weight: .regular)
        static let small = Font.system(size: 11, weight: .regular)
    }

    enum CornerRadius {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let circle: CGFloat = 50
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.hasPrefix("#") ? hex.index(after: hex.startIndex) : hex.startIndex

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
