//
//  DetailTextItemCell.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import UIKit

class DetailTextItemCell: UITableViewCell {
    static let cellIdent = "DetailTextItemCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    func configure(item: DetailsItemModel) {
        titleLabel.text = item.title
        mainTextLabel.text = item.text
    }
}
