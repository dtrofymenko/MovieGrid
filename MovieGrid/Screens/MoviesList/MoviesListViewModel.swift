//
//  MoviesListViewModel.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation
import UIKit

struct MoviesListItem: Equatable {
    let title: String
    let posterURL: URL?
    let tapHandler: () -> Void

    static func == (lhs: MoviesListItem, rhs: MoviesListItem) -> Bool {
        return lhs.title == rhs.title
    }
}

protocol MoviesListView: ModelView {
    func viewDataDidUpdate()
}

protocol MoviesListViewModelDelegate: class {
    func moviesListViewModel(_ viewModel: MoviesListViewModel, didSelectMovie movie: Movie)
}

class MoviesListViewModel: ViewModel {

    struct ViewData: Equatable {
        var items: [MoviesListItem] = []
        var isLoadingMore: Bool = false
        var isRefreshing: Bool = false
    }

    typealias Factory = MoviesServiceFactory

    weak var delegate: MoviesListViewModelDelegate?

    private var view: MoviesListView { return (baseView as? MoviesListView)! }
    private let firstPage: Int = 1
    private var isLoadingInProcess: Bool = false
    private var currentPage: Int = 0
    private var totalPages: Int = 1
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

    func loadMore() {
        guard nextPage < totalPages else { return }
        updateViewData { $0.isLoadingMore = true }
        load(page: nextPage)
    }

    func refresh() {
        updateViewData { $0.isRefreshing = true }
        load(page: firstPage)
    }

    // MARK: - ViewModel
    override func viewWillAppear(isFirstAppearing: Bool) {
        if isFirstAppearing {
            refresh()
        }
    }

    // MARK: - Private
    private func updateViewData(updater: (inout ViewData) -> Void) {
        var viewData = self.viewData
        updater(&viewData)
        self.viewData = viewData
    }

    private func load(page: Int) {
        guard !isLoadingInProcess else { return }
        isLoadingInProcess = true

        moviesService.loadMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoadingInProcess = false

            self.updateViewData { viewData in
                viewData.isLoadingMore = false
                viewData.isRefreshing = false

                switch result {
                case .failure: break
                case .success(let model):
                    self.currentPage = page
                    self.totalPages = model.totalPages
                    let newItems = model.results.map {
                        return self.makeItemFromMovie($0)
                    }

                    if page == self.firstPage {
                        viewData.items = newItems
                    } else {
                        viewData.items += newItems
                    }
                }
            }
        }
    }

    private func makeItemFromMovie(_ movie: Movie) -> MoviesListItem {
        return MoviesListItem(title: movie.title,
                              posterURL: movie.makePosterURL(),
                              tapHandler: { [weak self] in
                                guard let self = self else { return }
                                self.delegate?.moviesListViewModel(self, didSelectMovie: movie)
        })
    }
}
