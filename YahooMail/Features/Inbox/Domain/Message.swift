import Foundation

struct Message: Identifiable, Equatable {
    let id: String
    let senderName: String
    let senderEmail: String
    let subject: String
    let preview: String
    let date: Date
    let isRead: Bool
    let avatarEmoji: String
}
