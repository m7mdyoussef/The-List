
import Foundation

class DetailsRemoteDatasource : BaseAPI<ApplicationNetworking>, DetailsRemoteDatasourceContract{
    
    func getRepoDetails(withUrl url:String ,completion: @escaping (Result<RepoDetailsModel?, APIError>) -> Void) {
        self.fetchData(target: .getRepoDetails(url: url), responseClass: RepoDetailsModel.self) { (result) in
            switch result {
            case .success(let followerModel):
                completion(.success(followerModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelAllRequests() {
        self.cancelAnyRequest()
    }
    
}
