import Foundation
import Combine

struct InboxViewState {
    var messages: [Message] = []
    var isLoading: Bool = false
    var error: String?
}

@MainActor
final class InboxViewModel: ObservableObject {
    @Published private(set) var state: InboxViewState = InboxViewState()

    private let fetchMessagesUseCase: FetchMessagesUseCase

    init(fetchMessagesUseCase: FetchMessagesUseCase) {
        self.fetchMessagesUseCase = fetchMessagesUseCase
    }

    func loadMessages() {
        state.isLoading = true
        state.error = nil

        Task {
            do {
                let messages = try await fetchMessagesUseCase.execute()
                state.messages = messages
                state.isLoading = false
            } catch {
                state.error = error.localizedDescription
                state.isLoading = false
            }
        }
    }
}
