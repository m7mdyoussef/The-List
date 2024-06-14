
import Foundation

protocol HomeViewModelContract : BaseViewModelContract {
    var errorHandler: ((String) -> Void)? { get set }
    var loadingHandler: ((Bool) -> Void)? { get set }
    var dataHandler: (([RepoModel]) -> Void)? { get set }
    func fetchRepos()
    func navigateTo(to: DestinationScreens)
}
