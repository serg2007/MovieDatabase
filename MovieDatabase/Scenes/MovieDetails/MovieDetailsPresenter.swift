//
//  MovieDetailsPresenter.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 07.05.2021.
//

import Foundation

class MovieDetailsPresenter: MvpPresenter<MovieDetailsView> {
    private let service = APIManager.shared
    
    private var movie: MovieModel?
    
    override func setContext(to context: RouteContext?) {
        guard let context = context else {
            return
        }
        movie = context[MovieDetailsVC.ArgMovieDetail]
    }
    
    func doOnStart() {
        if let movie = movie {
            mvpView?.updateView(movie: movie)
        }
        fetchCasts()
    }
    
    private func fetchCasts() {
        guard let movieId = movie?.id else {
            return
        }

        let parameters = ["api_key": APIManager.shared.apiKey] as [String : Any]
        APIManager.shared.getCredits(movieId: movieId, parameters: parameters) { result, error in
            guard let result = result else {
                return
            }
            
            self.processCasts(result)
        }
    }
    
    private func processCasts(_ casts: [Cast]) {
        let castDetail = DetailsItemModel(type: .text,
                                          title: "Cast",
                                          text: self.splitCasts(casts: casts))
        mvpView?.updateView(casts: castDetail)
    }
    
    private func splitCasts(casts: [Cast]) -> String {
        let castsNames = casts.map { $0.name }
        return castsNames.joined(separator:", ")
    }
}
