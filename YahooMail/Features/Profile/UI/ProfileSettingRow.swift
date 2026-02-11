import SwiftUI

struct ProfileSettingRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(DesignTokens.Colors.accent)
                .frame(width: 30)

            Text(title)
                .font(DesignTokens.Typography.body)
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(DesignTokens.Colors.secondary)
                .font(.caption)
        }
        .padding(DesignTokens.Spacing.md)
    }
}
