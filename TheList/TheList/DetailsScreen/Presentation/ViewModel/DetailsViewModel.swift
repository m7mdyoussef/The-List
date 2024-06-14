
import Foundation


class DetailsViewModel : DetailsViewModelContract{

        var coordinator: CoordinatorProtocol
        var errorHandler: ((String) -> Void)?
        var loadingHandler: ((Bool) -> Void)?
        var dataHandler: ((RepoDetailsModel) -> Void)?
        private let usecase:DetailsUseCaseContract
        var repoModel:RepoModel?
    
    init(repoModel:RepoModel,
        coordinator: CoordinatorProtocol,
        usecase: DetailsUseCaseContract) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.repoModel = repoModel
    }
    
    func fetchDetails(){
        if let url = repoModel?.owner?.url{
            self.fetchDetailsFollowers(withUrl: url)
        }
    }
    
    func fetchDetailsFollowers(withUrl url:String) {
        self.loadingHandler?(true)
        self.usecase.fetchRepoDetails(withUrl: url) {[weak self] result in
            guard let self else {return}
            self.loadingHandler?(false)
            switch result {
            case .success(let repoModel):
                if let repo = repoModel{
                    self.dataHandler?(repo)
                }else{
                    self.errorHandler?(APIError.emptyData.errorMessage)
                }
            case .failure(let error):
                self.errorHandler?(error.errorMessage)
            }

        }
    }

    func popBack() {
        coordinator.dismiss()
    }
}
