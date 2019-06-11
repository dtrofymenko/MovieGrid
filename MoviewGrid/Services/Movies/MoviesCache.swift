//
//  MoviesCache.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/11/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

enum MoviesCacheError: Swift.Error {
    case noCache
}

class MoviesCache {
    private static let cacheKey = "moviesCacheKey"
    private let queue = DispatchQueue(label: UUID().uuidString, qos: .utility)

    private var cachedData: [Int: MultiPageResult<Movie>] = [:] {
        didSet {
            guard 0 < cachedData.count else {
                UserDefaults.standard.set(nil, forKey: MoviesCache.cacheKey)
                return
            }
            guard let data = try? PropertyListEncoder().encode(cachedData) else { return }
            UserDefaults.standard.set(data, forKey: MoviesCache.cacheKey)
        }
    }

    init() {
        restore()
    }

    @discardableResult
    func loadMovies(page: Int, completion: @escaping (Swift.Result<MultiPageResult<Movie>, Swift.Error>) -> Void) -> Cancelable {
        let cancelable = DummyCancelable()
        queue.async {
            let data = self.cachedData[page]
            DispatchQueue.main.async {
                guard !cancelable.isCancelled else { return }

                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(MoviesCacheError.noCache))
                }
            }
        }
        return cancelable
    }

    func cache(data: MultiPageResult<Movie>) {
        queue.async {
            if 1 == data.page {
                self.cachedData = [1: data]
            } else {
                self.cachedData[data.page] = data
            }
        }
    }

    // MARK: - Private
    private func restore() {
        queue.async {
            guard let data = UserDefaults.standard.data(forKey: MoviesCache.cacheKey) else { return }
            guard let cachedData = try? PropertyListDecoder().decode([Int: MultiPageResult<Movie>].self, from: data) else {
                self.cachedData = [:]
                return
            }
            self.cachedData = cachedData
        }
    }
}

class DummyCancelable: Cancelable {
    var isCancelled: Bool = false
    func cancel() {
        isCancelled = true
    }
}
