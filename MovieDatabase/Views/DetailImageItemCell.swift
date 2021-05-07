//
//  DetailImageItemCell.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import UIKit

class DetailImageItemCell: UITableViewCell {
    static let cellIdent = "DetailImageItemCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configure(url: URL?) {
        posterImageView.sd_setImage(with: url)
    }
}
