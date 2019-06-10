//
//  MoviesListViewModel.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

protocol MovieDetailsView: ModelView {}

class MovieDetailsViewModel: ViewModel {
    struct ViewData {
        let title: String
        let posterURL: URL?
        let overview: String
    }

    var view: MovieDetailsView { return (baseView as? MovieDetailsView)! }

    var viewData: ViewData

    private let movie: Movie
    init(movie: Movie) {
        self.movie = movie
        viewData = ViewData(title: movie.title,
                            posterURL: movie.makePosterURL(),
                            overview: movie.overview)
    }
}
