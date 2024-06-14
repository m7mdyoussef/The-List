
import Foundation

struct ListTableViewCellModel: BaseCellViewModelProtocol {
    let repoName: String?
    let repoOwnerName: String?
    let repoOwnerImage: String?
    let createdAt:String?
    
    init(repoName: String?, repoOwnerName: String?, repoOwnerImage: String?, createdAt:String?) {
        self.repoName = repoName
        self.repoOwnerName = repoOwnerName
        self.repoOwnerImage  = repoOwnerImage
        
        if let createdAtString = createdAt,
           let createdAtDate = ISO8601DateFormatter().date(from: createdAtString) {
            self.createdAt = createdAtDate.timeAgoDisplay()
        } else {
            self.createdAt = Date().timeAgoDisplay()
        }
    }
}
