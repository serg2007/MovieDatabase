//
//  MovieListPresenter.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 07.05.2021.
//
import Foundation

enum State {
    case regular
    case search
}

class MovieListPresenter: MvpPresenter<MovieListView> {
    
    var moviesList = [MovieModel]()
    var genresList = [Genre]()
    var currentPage: Int = 1
    var isRequestStarted = false
    var state = State.regular
    var searchTimer: Timer?
    
    private let service = APIManager.shared
    
    func selectedCell(withRow: Int) {
        let parameters = [MovieDetailsVC.ArgMovieDetail: moviesList[withRow]]
        let context = RouteContext(parameters)
        mvpView?.openChildScreen(.MovieDetail, fromStoryboard: .main, withContext: context)
    }
    
    func doOnStart() {
        fetchGenres()
    }
    
    func loadMore(search: String?) {
        switch state {
        case .regular:
            fetchMovies()
        case .search:
            searchMovies(text: search ?? "")
        }
    }
    
    func clearList() {
        currentPage = 1
        moviesList.removeAll()
    }
    
    func fetchGenres() {
        let parameters = ["api_key": APIManager.shared.apiKey]
        APIManager.shared.getGenres(parameters: parameters) { result, error in
            guard let result = result else {return}
            self.genresList.append(contentsOf: result)
            self.fetchMovies()
        }
    }
    
    func fetchMovies() {
        if isRequestStarted {
            return
        }
        isRequestStarted = true
        let parameters = ["api_key": APIManager.shared.apiKey,
                          "page": currentPage] as [String : Any]
        APIManager.shared.getMovies(parameters: parameters) { result, error in
            self.isRequestStarted = false
            guard let result = result else {return}
            if let results = result.results {
                self.moviesList.append(contentsOf: results)
            }
            self.currentPage  += 1
            self.mvpView?.updateList()
        }
    }
    
    func searchMovies(text: String) {
        if isRequestStarted {
            return
        }
        isRequestStarted = true
        let parameters = ["api_key": APIManager.shared.apiKey,
                          "page": currentPage,
                          "query": text] as [String : Any]
        APIManager.shared.searchMovies(parameters: parameters) { result, error in
            self.isRequestStarted = false
            guard let result = result else {
                self.mvpView?.updateList()
                return
            }
            
            if let results = result.results {
                self.moviesList.append(contentsOf: results)
            }
            self.currentPage += 1
            self.mvpView?.updateList()
        }
    }
}
