//
//  Genre.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 07.05.2021.
//

struct GenresResult: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String?
}
