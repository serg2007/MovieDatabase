//
//  MvpView.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import UIKit

protocol MvpView {
    func openScreen(_ screen: Screen,
    fromStoryboard storyboard: Storyboard,
    withContext context: RouteContext?)

    func openChildScreen(_ screen: Screen,
    fromStoryboard storyboard: Storyboard,
    withContext context: RouteContext?)

    func backToPrevScreen(with context: RouteContext?)
}
