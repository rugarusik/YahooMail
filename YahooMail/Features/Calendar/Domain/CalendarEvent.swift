import Foundation

struct CalendarEvent: Identifiable {
    let id: UUID
    let title: String
    let date: Date
    let startTime: Date
    let endTime: Date
    let color: String
}
