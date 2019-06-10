//
//  Movie+PosterURL.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/10/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

extension Movie {
    func makePosterURL(width: Int = Config.current.posterWidth) -> URL? {
        guard let posterPath = posterPath else { return nil }

        let path = "w\(width)" + posterPath
        return Config.current.posterBaseURL.appendingPathComponent(path)
    }
}
