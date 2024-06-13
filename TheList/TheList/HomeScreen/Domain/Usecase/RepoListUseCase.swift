
import Foundation

class RepoListUseCase: RepoListUseCaseContract {

    
    private var repo: RepoListRepositoryContract
    
    init(repo: RepoListRepositoryContract) {
        self.repo = repo
        
    }
    
    func fetchRepos(completion: @escaping (Result<[RepoModel]?, APIError>) -> Void){
        self.repo.fetchRepos(completion: completion)
    }
    
//    private func bind(){
//        repo.dataHandler = { [weak self] repoArray in
//            guard let self = self else { return }
//            self.dataHandler?(repoArray)
//        }
//        
//        repo.errorHandler = { [weak self] message in
//            guard let self = self else { return }
//            self.errorHandler?(message)
//        }
//        
//        repo.loadingHandler = { [weak self] isLoading in
//            guard let self = self else { return }
//            self.loadingHandler?(isLoading)
//        }
//    }
}
