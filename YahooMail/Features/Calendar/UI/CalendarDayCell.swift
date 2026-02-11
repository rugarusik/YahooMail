import SwiftUI

struct CalendarDayCell: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(DesignTokens.Typography.body)
                .foregroundColor(isSelected ? DesignTokens.Colors.background : .white)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(
                    isSelected ? Color.white : (isToday ? DesignTokens.Colors.accent.opacity(0.3) : Color.clear)
                )
                .clipShape(Circle())
        }
    }
}
