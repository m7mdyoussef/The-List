
import Foundation

class RepoListUseCase: RepoListUseCaseContract {

    
    private var repo: RepoListRepositoryContract
    
    init(repo: RepoListRepositoryContract) {
        self.repo = repo
        
    }
    
    func fetchRepos(completion: @escaping (Result<[RepoModel]?, APIError>) -> Void){
        self.repo.fetchRepos(completion: completion)
    }
}
