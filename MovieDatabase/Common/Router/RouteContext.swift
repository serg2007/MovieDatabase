//
//  RouteContext.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

protocol RoutableScreen {
    var context: RouteContext? { get set }
}

struct RouteContext {
    private let params: [String: Any]
    
    subscript<T>(key: String) -> T? {
        return params[key] as? T
    }
    
    init(_ params: [String: Any]) {
        self.params = params
    }
}

