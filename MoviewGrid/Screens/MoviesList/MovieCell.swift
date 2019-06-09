//
//  MovieCell.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func update(item: MoviesListItem) {
        titleLabel.text = item.name
    }

    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    // MARK: - Private
    private func setup() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
        titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        titleLabel.textColor = UIColor.tintColor
    }
}
