import Foundation

final class LocalProfileRepository: ProfileRepository {
    func getProfile() async -> UserProfile {
        UserProfile(
            name: "Alina Golubeva",
            email: "alina.golubeva@example.com",
            avatarEmoji: "👩‍💻"
        )
    }
}
