import Foundation
import Combine

struct CalendarViewState {
    var selectedDate: Date = Date()
    var currentMonth: Date = Date()
    var events: [CalendarEvent] = []
}

@MainActor
final class CalendarViewModel: ObservableObject {
    @Published private(set) var state: CalendarViewState = CalendarViewState()

    func selectDate(_ date: Date) {
        state.selectedDate = date
    }

    func changeMonth(by offset: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: offset, to: state.currentMonth) {
            state.currentMonth = newMonth
        }
    }

    func loadEvents() {
        state.events = []
    }
}
