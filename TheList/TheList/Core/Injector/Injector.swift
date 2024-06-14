
import UIKit

class Injector {
    
    static func getSplashViewController(coordinator: CoordinatorProtocol) -> SplashScreenViewController {
        let viewModel = SplashScreenViewModel(coordinator: coordinator)
        let viewcontroller = SplashScreenViewController.instantiateFromStoryBoard(appStoryBoard: .Splash)
        viewcontroller.viewModel = viewModel
        return viewcontroller
    }
    
    static func getHomeViewController(coordinator: CoordinatorProtocol) -> HomeViewController {
        let remoteDatasource = ListRemoteDatasource()
        let repo = RepoListRepository(listRemoteDatasource: remoteDatasource)
        let usecase = RepoListUseCase(repo: repo)
        let viewModel = HomeViewModel(coordinator: coordinator, usecase: usecase)
        let viewcontroller = HomeViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
        viewcontroller.RepoListViewModel = viewModel
        return viewcontroller
    }
    
    static func getRepoDetailsViewController(coordinator: CoordinatorProtocol, repoModel: RepoModel) -> DetailsViewController {
        let remoteDatasource = DetailsRemoteDatasource()
        let repo = DetailsRepository(detailsRemoteDatasource: remoteDatasource)
        let usecase = DetailsUseCase(repo: repo)
        let viewModel = DetailsViewModel(repoModel: repoModel, coordinator: coordinator, usecase: usecase)
        let viewcontroller = DetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Details)
        viewcontroller.detailsViewModel = viewModel
        return viewcontroller
    }
    
}
