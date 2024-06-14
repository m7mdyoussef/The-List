
import Foundation

class DetailsRepository: DetailsRepositoryContract {
    
    private var detailsRemoteDatasource: DetailsRemoteDatasourceContract!
    init(detailsRemoteDatasource: DetailsRemoteDatasourceContract) {
        self.detailsRemoteDatasource = detailsRemoteDatasource
    }
    
    func fetchRepoDetails(withUrl url:String ,completion: @escaping (Result<RepoDetailsModel?, APIError>) -> Void) {
        
        detailsRemoteDatasource.getRepoDetails(withUrl:url) { [weak self] result in
            guard let self = self else {
                return
            }
            completion(result)
        }
    }
}
