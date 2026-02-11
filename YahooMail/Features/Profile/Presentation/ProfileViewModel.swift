import Foundation
import Combine

struct ProfileViewState {
    var profile: UserProfile?
    var isLoading: Bool = false
}

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var state: ProfileViewState = ProfileViewState()

    private let repository: ProfileRepository

    init(repository: ProfileRepository) {
        self.repository = repository
    }

    func loadProfile() {
        state.isLoading = true

        Task {
            let profile = await repository.getProfile()
            state.profile = profile
            state.isLoading = false
        }
    }
}
