//
//  MultiPageResult.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

struct MultiPageResult<T: Decodable>: Decodable {
    let page: Int
    let totalPages: Int
    let results: [T]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}
