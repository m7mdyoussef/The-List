
import Foundation

protocol RepoListUseCaseContract {
    func fetchRepos(completion: @escaping (Result<[RepoModel]?, APIError>) -> Void)
}
