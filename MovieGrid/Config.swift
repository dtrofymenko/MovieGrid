//
//  Config.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

struct Config {
    static let current = Config()

    let posterBaseURL = URL(string: "https://image.tmdb.org/t/p/")!
    let posterWidth = 500

    let apiKey: String = "ebea8cfca72fdff8d2624ad7bbf78e4c"
}
