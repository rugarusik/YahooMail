import Foundation

protocol ProfileRepository {
    func getProfile() async -> UserProfile
}
