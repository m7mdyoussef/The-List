
import Foundation

struct RepoModel: Codable {
    let id: Int?
    let name, fullName: String?
    let owner: Owner?
    let url: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case url
        case createdAt = "created_at"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let avatarURL: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case url
    }
}
