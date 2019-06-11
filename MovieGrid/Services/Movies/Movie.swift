//
//  Movie.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

struct Movie: Codable {
    let identifier: Int
    let title: String
    let posterPath: String?
    let voteAverage: Float
    let releaseDateString: String
    let overview: String
    let isAdult: Bool

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDateString = "release_date"
        case overview
        case isAdult = "adult"
    }

    var releaseDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: releaseDateString)
    }
}
