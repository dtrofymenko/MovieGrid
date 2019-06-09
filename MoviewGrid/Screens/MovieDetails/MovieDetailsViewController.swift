//
//  MovieDetailsViewController.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class MovieDetailsViewController: ModelViewController<MovieDetailsViewModel>, MovieDetailsView {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.movieDetails.name
    }
}
