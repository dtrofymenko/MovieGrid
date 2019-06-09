//
//  MoviesListViewModel.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

struct MovieDetails {
    let title: String
    let url: URL?

    static let stub = MovieDetails(title: "Antman", url: URL(string: "124"))
}

protocol MovieDetailsView: ModelView {}

class MovieDetailsViewModel: ViewModel {
    var view: MovieDetailsView { return (baseView as? MovieDetailsView)! }

    var movieDetails = MovieDetails.stub

    private let movie: NSObject
    init(movie: NSObject) {
        self.movie = movie
    }
}
