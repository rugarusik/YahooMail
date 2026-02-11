import SwiftUI

struct MessageRowView: View {
    let message: Message

    var body: some View {
        HStack(alignment: .top, spacing: DesignTokens.Spacing.md) {
            Text(message.avatarEmoji)
                .font(.title)
                .frame(width: 50, height: 50)
                .background(DesignTokens.Colors.secondaryBackground)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(message.senderName)
                        .font(DesignTokens.Typography.headline)
                        .foregroundColor(DesignTokens.Colors.primary)

                    Spacer()

                    Text(timeString(from: message.date))
                        .font(DesignTokens.Typography.caption)
                        .foregroundColor(DesignTokens.Colors.secondary)
                }

                Text(message.subject)
                    .font(DesignTokens.Typography.body)
                    .foregroundColor(DesignTokens.Colors.primary)
                    .lineLimit(1)

                Text(message.preview)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.secondary)
                    .lineLimit(2)
            }
        }
        .padding(DesignTokens.Spacing.md)
        .background(DesignTokens.Colors.background)
    }

    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
