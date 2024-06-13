
import Foundation

protocol HomeViewModelContract : BaseViewModelContract {
    func fetchRepos()
    var errorHandler: ((String) -> Void)? { get set }
    var loadingHandler: ((Bool) -> Void)? { get set }
    var dataHandler: (([RepoModel]) -> Void)? { get set }
}
