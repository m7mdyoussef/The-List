
import Foundation

protocol DetailsUseCaseContract {
    func fetchRepoDetails(withUrl:String ,completion: @escaping (Result<RepoDetailsModel?, APIError>) -> Void)
}
