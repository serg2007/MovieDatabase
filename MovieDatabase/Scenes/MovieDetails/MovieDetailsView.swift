//
//  MovieDetailsView.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 07.05.2021.
//

import Foundation

protocol MovieDetailsView: MvpView {
    func updateView(movie: MovieModel)
    func updateView(casts: DetailsItemModel)
}
