
import Foundation
protocol ListRemoteDatasourceContract {
    func getRepoList(completion: @escaping (Result<[RepoModel]?,APIError>) -> Void)
    func cancelAllRequests()
}
