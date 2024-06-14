
import Foundation
protocol DetailsRemoteDatasourceContract {
    func getRepoDetails(withUrl:String ,completion: @escaping (Result<RepoDetailsModel?,APIError>) -> Void)
    func cancelAllRequests()
}
