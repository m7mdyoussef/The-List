//
//  ViewController+Extension.swift
//  TheList
//
//  Created by mohamed youssef on 13/06/2024.
//

import UIKit

extension UIViewController {
    
    static func instantiateFromStoryBoard(appStoryBoard : StoryBoardsEnum) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }

}
