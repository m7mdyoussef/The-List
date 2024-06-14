
import UIKit


class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let nextViewController = Injector.getHomeViewController(coordinator: self)
        navigationController.pushViewController(nextViewController, animated: false)
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    func navigateToRoot() {
        DispatchQueue.main.async {
            self.navigationController.popToRootViewController(animated: true)
            self.navigationController.dismiss(animated: true)
        }
    }
            
    func navigateToNextScreen(destination: DestinationScreens){
        switch destination{
        case .Splash:
            start()
        case .Home:
            openHomeScreen()
        case .Details(let repoMode):
            openRepoDetailsScreen(repoModel: repoMode)
        }
        
    }
    
    private func openHomeScreen() {
        let nextViewController = Injector.getHomeViewController(coordinator: self)
        navigationController.pushViewController(nextViewController, animated: false)
    }
    
    private func openRepoDetailsScreen(repoModel: RepoModel) {
        let nextViewController = Injector.getRepoDetailsViewController(coordinator: self, repoModel: repoModel)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}
