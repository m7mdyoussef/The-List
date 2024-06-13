
import Foundation

class ListRemoteDatasource : BaseAPI<ApplicationNetworking>, ListRemoteDatasourceContract{

    func getRepoList(completion: @escaping (Result<[RepoModel]?, APIError>) -> Void) {
        self.fetchData(target: .getList, responseClass: [RepoModel].self) { (result) in
            switch result {
            case .success(let repoList):
                completion(.success(repoList))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
    
    func cancelAllRequests() {
        self.cancelAnyRequest()
    }

}
