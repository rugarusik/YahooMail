import Foundation

final class DependencyContainer {
    // MARK: - Repositories
    private lazy var messageRepository: MessageRepository = LocalMessageRepository()
    private lazy var profileRepository: ProfileRepository = LocalProfileRepository()

    // MARK: - Use Cases
    private lazy var fetchMessagesUseCase = FetchMessagesUseCase(repository: messageRepository)

    // MARK: - ViewModels
    func makeInboxViewModel() -> InboxViewModel {
        InboxViewModel(fetchMessagesUseCase: fetchMessagesUseCase)
    }

    func makeCalendarViewModel() -> CalendarViewModel {
        CalendarViewModel()
    }

    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(repository: profileRepository)
    }
}
