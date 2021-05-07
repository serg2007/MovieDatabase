//
//  Router.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import UIKit

class Router {
    
    let currentController: UIViewController
    
    init(viewController: UIViewController) {
        self.currentController = viewController
    }
    
    func openScreen(_ screen: Screen,
                    fromStoryboard storyboard: Storyboard,
                    isChildScreen: Bool,
                    withContext context: RouteContext? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        
        if var nextRoutableScreen = nextViewController as? RoutableScreen {
            nextRoutableScreen.context = context
        }
        if isChildScreen {
            currentController.navigationController?
                .pushViewController(nextViewController, animated: true)
        } else {
            currentController.present(nextViewController, animated: true, completion: nil)
        }
    }

    func backToPrevScreen(with context: RouteContext? = nil) {
        
        if let stackScreensCount = currentController.navigationController?.viewControllers.count, var prevRoutableController = currentController.navigationController?.viewControllers[stackScreensCount-2] as? RoutableScreen {
            prevRoutableController.context = context
        }
        
        currentController.navigationController?
            .popViewController(animated: true)
        
    }
    
}
