
import Foundation

protocol RepoListRepositoryContract {
    func fetchRepos(completion: @escaping (Result<[RepoModel]?, APIError>) -> Void)
}
