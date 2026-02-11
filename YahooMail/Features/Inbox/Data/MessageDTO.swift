import Foundation

struct MessageDTO: Codable {
    let id: String
    let senderName: String
    let senderEmail: String
    let subject: String
    let preview: String
    let date: String
    let isRead: Bool
    let avatarEmoji: String
}
