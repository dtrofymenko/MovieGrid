//
//  FlowCoordinator.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class FlowCoordinator {
    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMoviesList()
    }
}

extension FlowCoordinator: MoviesListViewModelDelegate {
    func showMoviesList() {
        guard let viewController = MoviesListViewController.instantiateFromStoryboard(viewModel: MoviesListViewModel()) else {
            return
        }
        viewController.viewModel.delegate = self
        navigationController.setViewControllers([viewController], animated: false)
    }

    // MARK: - MoviesListViewModelDelegate
    func moviesListViewModel(_ viewModel: MoviesListViewModel, didSelectMovie movie: Movie) {
        showMovieDetailsScreen(movie: movie)
    }
}

extension FlowCoordinator {
    func showMovieDetailsScreen(movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie)
        guard let viewController = MovieDetailsViewController.instantiateFromStoryboard(viewModel: viewModel) else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
