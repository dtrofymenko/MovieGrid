//
//  MovieInfoItemView.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/10/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class MovieInfoItemView: UIView {
    struct Metrics {
        static let titleToValueOffset: CGFloat = 0.0
    }
    private var titleLabel: UILabel!
    private var valueLabel: UILabel!

    var title: String? {
        didSet {
            titleLabel.text = title
            setNeedsLayout()
        }
    }
    var value: String? {
        didSet {
            valueLabel.text = value
            setNeedsLayout()
        }
    }

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

    // MARK: - Private
    private func setup() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .light)
        titleLabel.textColor = .detailsTextColor

        valueLabel = UILabel()
        valueLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = .systemFont(ofSize: 20.0, weight: .regular)
        valueLabel.textColor = .white

        addSubview(titleLabel)
        addSubview(valueLabel)

        let views = ["titleLabel": titleLabel!,
                     "valueLabel": valueLabel!]
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[valueLabel]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]-titleToValueOffset-[valueLabel]|",
                                                      options: [],
                                                      metrics: ["titleToValueOffset": Metrics.titleToValueOffset],
                                                      views: views)
        addConstraints(constraints)
    }
}
