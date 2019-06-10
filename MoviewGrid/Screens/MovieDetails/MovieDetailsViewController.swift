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

        scoreInfoView.title = NSLocalizedString("Score:", comment: "")
        scoreInfoView.value = "8.2"
        ratingInfoView.title = NSLocalizedString("Rating:", comment: "")
        ratingInfoView.value = "R"
        relaseDataInfoView.title = NSLocalizedString("Release Date:", comment: "")
        relaseDataInfoView.value = "July 17, 2015"

        overviewLabel.text = viewData.overview
        titleLabel.text = viewData.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        posterImageView.kf.setImage(with: viewData.posterURL,
                                    options: [.backgroundDecode,
                                              .scaleFactor(UIScreen.main.scale)])

    }
}
