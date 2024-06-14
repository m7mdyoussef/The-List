
import UIKit

extension UIViewController {
    
    static func instantiateFromStoryBoard(appStoryBoard : StoryBoardsEnum) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }
}
