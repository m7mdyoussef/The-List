
import Foundation

class SplashScreenViewModel: SplashViewModelContract {
    var coordinator: CoordinatorProtocol
    
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func navigateTo(to: DestinationScreens) {
        coordinator.navigateToNextScreen(destination: to)
    }
}
