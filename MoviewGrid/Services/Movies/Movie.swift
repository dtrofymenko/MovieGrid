//
//  Movie.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let identifier: Int
    let title: String
    let posterPath: String?
    let voteAverage: Float
    let releaseDate: Date
    let overview: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        identifier = try values.decode(Int.self, forKey: .identifier)
        title = try values.decode(String.self, forKey: .title)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        voteAverage = try values.decode(Float.self, forKey: .voteAverage)

        let releaseDateString = try values.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let releaseDate = dateFormatter.date(from: releaseDateString) else {
            throw CustomError.unknownError
        }
        self.releaseDate = releaseDate
        overview = try values.decode(String.self, forKey: .overview)
    }
}
