//
//  MoviesService.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

protocol MoviesService {
    @discardableResult
    func loadMovies(page: Int, completion: @escaping (Swift.Result<MultiPageResult<Movie>, Swift.Error>) -> Void) -> Cancelable
}

protocol MoviesServiceFactory {
    func makeMoviesService() -> MoviesService
}

extension SharedFactory: MoviesServiceFactory {
    func makeMoviesService() -> MoviesService {
        return MoviesServiceImp(apiKey: Config.current.apiKey)
    }
}
