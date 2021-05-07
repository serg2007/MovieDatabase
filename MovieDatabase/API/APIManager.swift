//
//  APIManager.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

import Foundation
import Alamofire

struct APIManager {
    
    static var shared: APIManager {
        return APIManager()
    }
    private init() {}
    let baseImageURLString = "https://image.tmdb.org/t/p/original"
    let baseURLString = "https://api.themoviedb.org/3"
    let apiKey = "815b63b537c380370911f6cb083031b0"
    
    
}


extension APIManager{
    
    func getMovies(parameters: [String : Any], completion: @escaping (_ results: MovieModelResult?, _ error: AFError?) -> Void ){
        guard let url = URL(string: baseURLString)?.appendingPathComponent("/movie/popular"),
              let urlRequest = try? URLRequest(url: url, method: .get),
              let encodedUrlRequest = try? URLEncoding().encode(urlRequest, with: parameters) else {return}

        AF.request(encodedUrlRequest)
            .responseJSON {
                response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let movies = try? JSONDecoder().decode(MovieModelResult.self, from: data)
                        return completion(movies, nil)
                    } else {
                        completion(nil, nil)
                    }
                case let .failure(err):
                    return completion(nil, err)
                }

        }
    }
    
    func getGenres(parameters: [String : Any], completion: @escaping (_ results: [Genre]?, _ error: AFError?) -> Void ){
        guard let url = URL(string: baseURLString)?.appendingPathComponent("/genre/movie/list"),
              let urlRequest = try? URLRequest(url: url, method: .get),
              let encodedUrlRequest = try? URLEncoding().encode(urlRequest, with: parameters) else {return}

        AF.request(encodedUrlRequest)
            .responseJSON {
                response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let genres = try? JSONDecoder().decode(GenresResult.self, from: data)
                        return completion(genres?.genres, nil)
                    } else {
                        completion(nil, nil)
                    }
                case let .failure(err):
                    return completion(nil, err)
                }
        }
    }
    
    func searchMovies(parameters: [String : Any], completion: @escaping (_ results: MovieModelResult?, _ error: AFError?) -> Void ){
        guard let url = URL(string: baseURLString)?.appendingPathComponent("/search/movie"),
              let urlRequest = try? URLRequest(url: url, method: .get),
              let encodedUrlRequest = try? URLEncoding().encode(urlRequest, with: parameters) else {return}

        AF.request(encodedUrlRequest)
            .responseJSON {
                response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let movies = try? JSONDecoder().decode(MovieModelResult.self, from: data)
                        return completion(movies, nil)
                    } else {
                        completion(nil, nil)
                    }
                case let .failure(err):
                    return completion(nil, err)
                }

        }
    }
    
    func getCredits(movieId: Int, parameters: [String : Any], completion: @escaping (_ results: [Cast]?, _ error: AFError?) -> Void ){
        guard let url = URL(string: baseURLString)?.appendingPathComponent("movie/\(movieId)/credits"),
              let urlRequest = try? URLRequest(url: url, method: .get),
              let encodedUrlRequest = try? URLEncoding().encode(urlRequest, with: parameters) else {return}

        AF.request(encodedUrlRequest)
            .responseJSON {
                response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let genres = try? JSONDecoder().decode(CreditsModelResult.self, from: data)
                        return completion(genres?.cast, nil)
                    } else {
                        completion(nil, nil)
                    }
                case let .failure(err):
                    return completion(nil, err)
                }
        }
    }
}
