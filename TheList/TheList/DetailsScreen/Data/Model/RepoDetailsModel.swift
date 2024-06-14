
import Foundation

// MARK: - WelcomeElement
struct RepoDetailsModel: Codable {
        let login: String?
        let avatarURL: String?
        let name, company: String?
        let blog: String?
        let location: String?
        let email: String?
        let twitterUsername: String?
        let followers, following: Int?

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
            case name, company, blog, location, email
            case twitterUsername = "twitter_username"
            case followers, following
        }

}

