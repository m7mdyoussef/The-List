
import Foundation

protocol BaseViewModelContract {
    var errorObservable: ((String) -> Void)? { get set }
    var loadingObservable: ((Bool) -> Void)? { get set }
    var coordinator: CoordinatorProtocol { get set }
    func navigateTo(to: DestinationScreens)
}
