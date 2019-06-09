//
//  MoviesListViewModel.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

struct MoviesListItem {
    let name: String
    let url: URL?

    static let stub = MoviesListItem(name: "Antman", url: URL(string: "124"))
}

protocol MoviesListView: ModelView {
    func itemsDidUpdate()
}

protocol MoviesListViewModelDelegate: class {
    func moviesListViewModelDidSelectMovie(_ viewModel: MoviesListViewModel,
                                           didSelectMovie movie: NSObject)
}

class MoviesListViewModel: ViewModel {
    var view: MoviesListView { return (baseView as? MoviesListView)! }
    weak var delegate: MoviesListViewModelDelegate?

    var items: [MoviesListItem] = [MoviesListItem.stub,
                                   MoviesListItem.stub,
                                   MoviesListItem.stub,
                                   MoviesListItem.stub] {
        didSet {
            view.itemsDidUpdate()
        }
    }

    func selectItem(_ item: MoviesListItem) {
        delegate?.moviesListViewModelDidSelectMovie(self, didSelectMovie: NSObject())
    }
}
