//
//  Base.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import UIKit

class BaseVC<P>: UIViewController, RoutableScreen {

    var context: RouteContext?
    var presenter: P?
    var router: Router {
        return Router(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        initPresenter(with: context)
    }

    func initPresenter(with context: RouteContext?) {
        fatalError("Subclasses must implement initPresenter()")
    }

    func setupStyle() {
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension BaseVC: MvpView {
    func openScreen(_ screen: Screen,
                    fromStoryboard storyboard: Storyboard,
                    withContext context: RouteContext? = nil) {
        Router(viewController: self)
            .openScreen(screen, fromStoryboard: storyboard, isChildScreen: false, withContext: context)
    }

    func openChildScreen(_ screen: Screen,
                         fromStoryboard storyboard: Storyboard,
                         withContext context: RouteContext? = nil) {
        Router(viewController: self)
            .openScreen(screen, fromStoryboard: storyboard, isChildScreen: true, withContext: context)
    }

    func backToPrevScreen(with context: RouteContext? = nil) {
        Router(viewController: self).backToPrevScreen(with: context)
    }
}
