
import UIKit

class SplashScreenViewController: UIViewController {
    
    var viewModel: SplashViewModelContract!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.navigateTo(to: .Home)
    }
}
