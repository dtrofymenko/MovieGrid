//
//  MoviesListViewModel.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

struct MoviesListItem: Equatable {
    let title: String
}

protocol MoviesListView: ModelView {
    func viewDataDidUpdate()
}

protocol MoviesListViewModelDelegate: class {
    func moviesListViewModelDidSelectMovie(_ viewModel: MoviesListViewModel,
                                           didSelectMovie movie: NSObject)
}

class MoviesListViewModel: ViewModel {

    struct ViewData: Equatable {
        var items: [MoviesListItem] = []
        var isLoadingMore: Bool = false
    }

    typealias Factory = MoviesServiceFactory

    weak var delegate: MoviesListViewModelDelegate?

    private var view: MoviesListView { return (baseView as? MoviesListView)! }
    private var isLoading: Bool = false
    private let firstPage: Int = 1
    private var currentPage: Int = 0
    private var nextPage: Int {
        return currentPage + 1
    }
    private let moviesService: MoviesService

    private(set) var viewData = ViewData() {
        didSet {
            guard viewData != oldValue else { return }
            view.viewDataDidUpdate()
        }
    }

    init(factory: Factory = SharedFactory.shared) {
        moviesService = factory.makeMoviesService()
    }

    func selectItem(_ item: MoviesListItem) {
        delegate?.moviesListViewModelDidSelectMovie(self, didSelectMovie: NSObject())
    }

    func loadMore() {
        updateViewData { $0.isLoadingMore = true }
        load(page: nextPage)
    }

    // MARK: - ViewModel
    override func viewWillAppear(isFirstAppearing: Bool) {
        if isFirstAppearing {
            load(page: firstPage)
        }
    }

    // MARK: - Private
    private func updateViewData(updater: (inout ViewData) -> Void) {
        var viewData = self.viewData
        updater(&viewData)
        self.viewData = viewData
    }

    func load(page: Int) {
        guard !isLoading else { return }
        isLoading = true
        moviesService.loadMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            self.updateViewData { viewData in
                viewData.isLoadingMore = false

                switch result {
                case .failure: break
                case .success(let model):
                    self.currentPage = page
                    viewData.items += model.results.map {
                        return MoviesListItem(title: $0.title)
                    }
                }
            }
        }
    }
}
