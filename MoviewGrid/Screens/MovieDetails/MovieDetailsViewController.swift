//
//  MovieDetailsViewController.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: ModelViewController<MovieDetailsViewModel>, MovieDetailsView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scoreInfoView: MovieInfoItemView!
    @IBOutlet weak var ratingInfoView: MovieInfoItemView!
    @IBOutlet weak var relaseDataInfoView: MovieInfoItemView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    var viewData: MovieDetailsViewModel.ViewData {
        return viewModel.viewData
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewData.title

        posterImageView.layer.cornerRadius = 10.0
        scoreInfoView.title = NSLocalizedString("Score:", comment: "")
        ratingInfoView.title = NSLocalizedString("Rating:", comment: "")
        relaseDataInfoView.title = NSLocalizedString("Release Date:", comment: "")

        ratingInfoView.value = "R"
        relaseDataInfoView.value = "July 17, 2015"
        scoreInfoView.value = "8.2"
        overviewLabel.text = viewData.overview
        titleLabel.text = viewData.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        posterImageView.kf.setImage(with: viewData.posterURL,
                                    options: [.backgroundDecode,
                                              .scaleFactor(UIScreen.main.scale)])
        backgroundImageView.kf.setImage(with: viewData.posterURL,
                                        options: [.backgroundDecode,
                                                  .scaleFactor(UIScreen.main.scale)])
    }
}
