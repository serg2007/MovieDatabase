//
//  MovieCell.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    static let cellIdent = "MovieCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var gentreLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func prepareForReuse() {
        posterImage.sd_cancelCurrentImageLoad()
        posterImage.image = nil
    }
    
    func configure(movie: MovieModel, genres: [Genre]) {
        titleLabel.text = movie.title
        subtitleLabel.text = splitGenres(ids: movie.genreIDS ?? [], genres: genres)
        if let posterPath = movie.posterPath {
            posterImage?.sd_setImage(with: URL(string: APIManager.shared.baseImageURLString + posterPath))
        }
        progressView.progress = Float((movie.voteAverage ?? 0) / Double(10))
        gradeLabel.text = "\(movie.voteAverage ?? 0)"
    }
    
    func splitGenres(ids: [Int], genres: [Genre]) -> String {
        let genresNames = ids.map { id in
            return genres.first{$0.id == id}?.name ?? ""
        }
        return genresNames.joined(separator:", ")
    }
}
