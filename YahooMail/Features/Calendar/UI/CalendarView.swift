import SwiftUI

struct CalendarView: View {
    @StateObject var viewModel: CalendarViewModel

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        NavigationView {
            ZStack {
                DesignTokens.Colors.background
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Button(action: { viewModel.changeMonth(by: -1) }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Text(monthYearString)
                            .font(DesignTokens.Typography.title)
                            .foregroundColor(.white)

                        Spacer()

                        Button(action: { viewModel.changeMonth(by: 1) }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(DesignTokens.Spacing.md)

                    HStack(spacing: 0) {
                        ForEach(weekDays, id: \.self) { day in
                            Text(day)
                                .font(DesignTokens.Typography.caption)
                                .foregroundColor(DesignTokens.Colors.secondary)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, DesignTokens.Spacing.md)
                    .padding(.bottom, DesignTokens.Spacing.sm)

                    LazyVGrid(columns: columns, spacing: DesignTokens.Spacing.sm) {
                        ForEach(generateDatesForMonth(), id: \.self) { date in
                            if let date = date {
                                CalendarDayCell(
                                    date: date,
                                    isSelected: Calendar.current.isDate(date, inSameDayAs: viewModel.state.selectedDate),
                                    isToday: Calendar.current.isDateInToday(date)
                                ) {
                                    viewModel.selectDate(date)
                                }
                            } else {
                                Color.clear
                                    .frame(height: 40)
                            }
                        }
                    }
                    .padding(.horizontal, DesignTokens.Spacing.md)

                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                        Text("Events")
                            .font(DesignTokens.Typography.headline)
                            .foregroundColor(.white)

                        if viewModel.state.events.isEmpty {
                            Text("No events for this day")
                                .font(DesignTokens.Typography.body)
                                .foregroundColor(DesignTokens.Colors.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, DesignTokens.Spacing.md)
                    .padding(.top, DesignTokens.Spacing.lg)

                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.loadEvents()
        }
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: viewModel.state.currentMonth)
    }

    private func generateDatesForMonth() -> [Date?] {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: viewModel.state.currentMonth)
        let year = calendar.component(.year, from: viewModel.state.currentMonth)

        guard let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1)),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        var dates: [Date?] = Array(repeating: nil, count: firstWeekday - 1)

        for day in range {
            if let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) {
                dates.append(date)
            }
        }

        return dates
    }
}
