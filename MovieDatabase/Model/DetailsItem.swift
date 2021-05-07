//
//  DetailsItem.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 07.05.2021.
//
import Foundation

enum DetailsType {
    case image
    case text
}

struct DetailsItemModel {
    var type: DetailsType
    var title: String?
    var text: String?
    var imageUrl: URL?
}
