
import Foundation

class DetailsUseCase: DetailsUseCaseContract {

    
    private var repo: DetailsRepositoryContract
    
    init(repo: DetailsRepositoryContract) {
        self.repo = repo
        
    }
    
    func fetchRepoDetails(withUrl url:String , completion: @escaping (Result<RepoDetailsModel?, APIError>) -> Void){
        self.repo.fetchRepoDetails(withUrl: url, completion: completion)
    }
}
