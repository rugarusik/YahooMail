import Foundation

struct MessageMapper {
    static func toDomain(_ dto: MessageDTO) -> Message? {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dto.date) else {
            return nil
        }

        return Message(
            id: dto.id,
            senderName: dto.senderName,
            senderEmail: dto.senderEmail,
            subject: dto.subject,
            preview: dto.preview,
            date: date,
            isRead: dto.isRead,
            avatarEmoji: dto.avatarEmoji
        )
    }
}
