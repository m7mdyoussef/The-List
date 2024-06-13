
import Foundation

protocol SplashViewModelContract {
    func navigateTo(to: DestinationScreens)
    var coordinator: CoordinatorProtocol {set get}
}
