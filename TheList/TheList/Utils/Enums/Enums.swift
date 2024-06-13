
import UIKit

enum StoryBoardsEnum : String {
    case Splash = "SplashScreenViewController"
    case Home = "HomeViewController"
    case Details = "DetailsViewController"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type) ->T {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardID) as! T
    }
}
