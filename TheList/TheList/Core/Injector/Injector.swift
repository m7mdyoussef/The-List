
import UIKit

class Injector {
    
    static func getSplashViewController(coordinator: CoordinatorProtocol) -> SplashScreenViewController {
        let viewModel = SplashScreenViewModel(coordinator: coordinator)
        let viewcontroller = SplashScreenViewController.instantiateFromStoryBoard(appStoryBoard: .Splash)
        viewcontroller.viewModel = viewModel
        return viewcontroller
    }
    
//    static func getHomeViewController(coordinator: CoordinatorProtocol) -> MoviesViewController {
//        let repo =
//        let viewModel = MoviesViewController(coordinator: coordinator)
//        
//        let viewcontroller = MoviesViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
//        viewcontroller.viewModel = viewModel
//        return viewcontroller
//    }
    
    static func getHomeViewController(coordinator: CoordinatorProtocol) -> HomeViewController {
        let remoteDatasource = ListRemoteDatasource()
        let repo = RepoListRepository(listRemoteDatasource: remoteDatasource)
        let usecase = RepoListUseCase(repo: repo)
        let viewModel = HomeViewModel(coordinator: coordinator, usecase: usecase)
        let viewcontroller = HomeViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
        viewcontroller.RepoListViewModel = viewModel
        return viewcontroller
    }
    
}
