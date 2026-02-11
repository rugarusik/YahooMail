import Foundation

final class FetchMessagesUseCase {
    private let repository: MessageRepository

    init(repository: MessageRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Message] {
        try await repository.fetchMessages()
    }
}
