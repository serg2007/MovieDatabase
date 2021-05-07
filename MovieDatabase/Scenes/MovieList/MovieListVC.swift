//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 05.05.2021.
//

import UIKit
import PaginatedTableView

class MovieListVC: BaseVC<MovieListPresenter> {
    let heightForRow = CGFloat(120)
    let searchDelay = TimeInterval(2)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: PaginatedTableView! {
        didSet {
            let nib = UINib(nibName: MovieCell.cellIdent, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: MovieCell.cellIdent)
        }
    }
    
    override func initPresenter(with context: RouteContext?) {
        presenter = MovieListPresenter()
        presenter?.attachView(mvpView: self)
        presenter?.setContext(to: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "🍿 Movies"
        tableView.paginatedDelegate = self
        tableView.paginatedDataSource = self
        
        searchBar.delegate = self
        presenter?.doOnStart()
    }
}

extension MovieListVC: MovieListView {
    func updateList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MovieListVC: PaginatedTableViewDelegate, PaginatedTableViewDataSource {
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        presenter?.loadMore(search: searchBar.text)
        
        onSuccess?(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.moviesList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellIdent) as? MovieCell,
           let movie = presenter?.moviesList[indexPath.row],
           let genres = presenter?.genresList {
            cell.configure(movie: movie,
                           genres: genres)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedCell(withRow: indexPath.row)
    }
}

extension MovieListVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.clearList()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchTimer?.invalidate()
        if let text = searchBar.text, !text.isEmpty {
            presenter?.state = .search
            presenter?.searchTimer =  Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false) { _ in
                self.presenter?.clearList()
                self.presenter?.searchMovies(text: text)
            }
        } else {
            self.presenter?.state = .regular
            self.presenter?.clearList()
            self.presenter?.fetchMovies()
        }
    }
}

