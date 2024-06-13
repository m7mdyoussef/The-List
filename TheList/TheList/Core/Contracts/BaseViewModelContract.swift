
import Foundation

protocol BaseViewModelContract {
    var coordinator: CoordinatorProtocol { get set }
    func navigateTo(to: DestinationScreens)
}
