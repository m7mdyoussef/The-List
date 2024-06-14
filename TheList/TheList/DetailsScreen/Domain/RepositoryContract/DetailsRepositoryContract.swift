
import Foundation

protocol DetailsRepositoryContract {
    func fetchRepoDetails(withUrl:String ,completion: @escaping (Result<RepoDetailsModel?, APIError>) -> Void)
}
