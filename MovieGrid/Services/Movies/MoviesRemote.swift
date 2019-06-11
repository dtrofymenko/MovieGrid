//
//  MoviesRemote.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/11/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation
import Alamofire

class MoviesRemote {
    private let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    private let session: URLSession

    let apiKey: String
    init(apiKey: String) {
        self.apiKey = apiKey
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }

    @discardableResult
    func loadMovies(page: Int, completion: @escaping (Swift.Result<MultiPageResult<Movie>, Swift.Error>) -> Void) -> Cancelable {
        guard let url = makeURL(endpoint: "movie/now_playing", parameters: ["page": "\(page)"]) else {
            fatalError()
        }
        return load(url: url, completion: completion)
    }

    // MARK: - Private
    private func load<T: Decodable>(url: URL, completion: @escaping (Swift.Result<T, Swift.Error>) -> Void) -> Cancelable {
        let request = Alamofire.request(url).responseData(queue: DispatchQueue.global(qos: .userInitiated)) { response  in
            let complete: (Swift.Result<T, Swift.Error>) -> Void = { result in
                DispatchQueue.main.async {
                    if case .failure(let error) = result {
                        NSLog("\(error)")
                    }
                    completion(result)
                }
            }

            guard nil == response.result.error else {
                complete(.failure(response.result.error!))
                return
            }

            guard let data = response.data else {
                complete(.failure(CustomError.unknownError))
                return
            }

            let decoder = JSONDecoder()

            let model: T
            do {
                model = try decoder.decode(T.self, from: data)
            } catch let error {
                complete(.failure(error))
                return
            }
            complete(.success(model))
            }
            .validate()

        return request
    }

    private func makeURL(endpoint: String, parameters: [String: String]) -> URL? {
        let url = baseURL.appendingPathComponent(endpoint)
        guard var components = URLComponents(url: url.absoluteURL, resolvingAgainstBaseURL: false) else { return nil }

        var parameters = parameters
        parameters["api_key"] = apiKey
        parameters["language"] = NSLocale.current.languageCode ?? "en-US"

        components.queryItems = parameters.map { key, value -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }

        return components.url
    }
}

extension DataRequest: Cancelable {}
