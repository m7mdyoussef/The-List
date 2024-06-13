
import Foundation


class HomeViewModel : HomeViewModelContract{

        var coordinator: CoordinatorProtocol
        var errorHandler: ((String) -> Void)?
        var loadingHandler: ((Bool) -> Void)?
        var dataHandler: (([RepoModel]) -> Void)?
        private let usecase:RepoListUseCaseContract
    
    init(
        coordinator: CoordinatorProtocol,
        usecase: RepoListUseCaseContract
    ) {
        self.coordinator = coordinator
        self.usecase = usecase
    }
    
    func fetchRepos() {
        self.loadingHandler?(true)
        self.usecase.fetchRepos {[weak self] result in
            guard let self else {return}
            self.loadingHandler?(false)
            switch result {
            case .success(let repoModel):
                if let repos = repoModel , repos.count > 0{
                    self.dataHandler?(repos)
                }else{
                    self.errorHandler?(APIError.emptyData.errorMessage)
                }
            case .failure(let error):
                self.errorHandler?(error.errorMessage)
                
            }

        }
    }

    func navigateTo(to: DestinationScreens) {
        switch to {
        case .Details(let repoModel):
            coordinator.navigateToNextScreen(destination: .Details(repoModel))
        default: break
        }
    }
}
