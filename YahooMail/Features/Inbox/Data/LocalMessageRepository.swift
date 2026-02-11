import Foundation

final class LocalMessageRepository: MessageRepository {
    func fetchMessages() async throws -> [Message] {
        guard let url = Bundle.main.url(forResource: "messages", withExtension: "json") else {
            throw NSError(domain: "MessageRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "messages.json not found"])
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let dtos = try decoder.decode([MessageDTO].self, from: data)

        return dtos.compactMap { MessageMapper.toDomain($0) }
    }
}
