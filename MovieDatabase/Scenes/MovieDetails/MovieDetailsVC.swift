//
//  MovieDetailsVC.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import UIKit
import SDWebImage


class MovieDetailsVC: BaseVC<MovieDetailsPresenter> {
    let castsIndex = 2
    let imagesCellHeight = CGFloat(550)
    static let ArgMovieDetail = "ARG_MOVIE_DETAIL"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: DetailImageItemCell.cellIdent, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: DetailImageItemCell.cellIdent)
            let textNib = UINib(nibName: DetailTextItemCell.cellIdent, bundle: nil)
            tableView.register(textNib, forCellReuseIdentifier: DetailTextItemCell.cellIdent)
        }
    }
    
    var detailsItemModels = [DetailsItemModel]()
    
    override func initPresenter(with context: RouteContext?) {
        presenter = MovieDetailsPresenter()
        presenter?.attachView(mvpView: self)
        presenter?.setContext(to: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter?.doOnStart()
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MovieDetailsVC: MovieDetailsView {
    func updateView(movie: MovieModel) {
        title = movie.title
        let label = UILabel()
        label.text = "🏆 \(movie.voteAverage ?? 0)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: label)
        
        if let path = movie.posterPath {
            detailsItemModels.append(DetailsItemModel(type: .image, imageUrl: URL(string: APIManager.shared.baseImageURLString + path)))
        }
        detailsItemModels.append(DetailsItemModel(type: .text,
                                                  title: "Overview",
                                                  text: movie.overview))
        detailsItemModels.append(DetailsItemModel(type: .text,
                                                  title: "Cast",
                                                  text: ""))
        tableView.reloadData()
    }
    
    func updateView(casts: DetailsItemModel) {
        detailsItemModels[castsIndex] = casts
        tableView.reloadData()
    }
}

extension MovieDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsItemModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = detailsItemModels[indexPath.row]
        switch item.type {
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageItemCell.cellIdent) as? DetailImageItemCell {
                cell.configure(url: item.imageUrl)
                return cell
            }
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailTextItemCell.cellIdent) as? DetailTextItemCell {
                cell.configure(item: item)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = detailsItemModels[indexPath.row]
        switch item.type {
        case .image:
            return imagesCellHeight
        case .text:
            return UITableView.automaticDimension
        }
    }
}
