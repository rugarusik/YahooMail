import Foundation

protocol MessageRepository {
    func fetchMessages() async throws -> [Message]
}
