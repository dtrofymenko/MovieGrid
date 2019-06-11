//
//  MoviesServiceImp.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation
import Alamofire

class MoviesServiceImp: MoviesService {
    typealias Factory = ConnectivityServiceFactory

    let remote: MoviesRemote
    let cache = MoviesCache()
    let connectivity: ConnectivityService

    init(apiKey: String, factory: Factory = SharedFactory.shared) {
        remote = MoviesRemote(apiKey: apiKey)
        connectivity = factory.makeConnectivityService()
    }

    @discardableResult
    func loadMovies(page: Int, completion: @escaping (Swift.Result<MultiPageResult<Movie>, Swift.Error>) -> Void) -> Cancelable {
        if connectivity.isConnected {
            return loadRemote(page: page, completion: completion)
        } else {
            return loadCache(page: page, completion: completion)
        }
    }

    // MARK: - Private
    private func loadRemote(page: Int, completion: @escaping (Swift.Result<MultiPageResult<Movie>, Swift.Error>) -> Void) -> Cancelable {
        return remote.loadMovies(page: page) { [weak self] result in
            guard let self = self else { return }

            if case .success(let data) = result {
                self.cache.cache(data: data)
            }
            completion(result)
        }
    }

    private func loadCache(page: Int, completion: @escaping (Swift.Result<MultiPageResult<Movie>, Swift.Error>) -> Void) -> Cancelable {
        return cache.loadMovies(page: page) { result in completion(result) }
    }
}
