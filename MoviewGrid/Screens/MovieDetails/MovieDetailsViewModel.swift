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
        let releaseDateText: String
        let posterURL: URL?
        let overview: String
        let scoreText: String
        let ratingText: String
    }

    var view: MovieDetailsView { return (baseView as? MovieDetailsView)! }

    var viewData: ViewData!
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter
    }()

    private let movie: Movie
    init(movie: Movie) {
        self.movie = movie
        super.init()
        setup()
    }

    // MARK: - Private
    private func setup() {
        var title: String = movie.title
        var dateString = ""

        if let releaseDate = movie.releaseDate {
            if let releaseYear = Calendar.current.dateComponents([.year], from: releaseDate).year {
                title = "\(movie.title) (\(releaseYear))"
            }
            dateString = MovieDetailsViewModel.dateFormatter.string(from: releaseDate)
        }
        viewData = ViewData(title: title,
                            releaseDateText: dateString,
                            posterURL: movie.makePosterURL(),
                            overview: movie.overview,
                            scoreText: String(format: "%.2f", movie.voteAverage),
                            ratingText: movie.isAdult ? "NC-17" : "G")
    }
}
