
import Foundation

class RepoListRepository: RepoListRepositoryContract {

        private var listRemoteDatasource: ListRemoteDatasourceContract!

        init(
            listRemoteDatasource: ListRemoteDatasourceContract) {
            self.listRemoteDatasource = listRemoteDatasource
        }
     
        
    func fetchRepos(completion: @escaping (Result<[RepoModel]?, APIError>) -> Void) {

            listRemoteDatasource.getRepoList() { [weak self] result in
                guard let self = self else {
                    return
                }
                completion(result)
            }
        }
    }
