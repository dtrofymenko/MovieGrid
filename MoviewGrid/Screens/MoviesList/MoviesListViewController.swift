//
//  MoviesListViewController.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class MoviesListViewController: ModelViewController<MoviesListViewModel>, MoviesListView,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!

    private let numberOfCellsInRow = 2
    private var viewData: MoviesListViewModel.ViewData {
        return viewModel.viewData
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Latest Movies", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("back", comment: ""),
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)

        collectionViewLayout.minimumLineSpacing = 15.0
        collectionViewLayout.minimumInteritemSpacing = 20.0

        collectionView.backgroundColor = .backgroundColor
        collectionView.contentInset = UIEdgeInsets(top: 20.0,
                                                   left: 20.0,
                                                   bottom: 20.0,
                                                   right: 20.0)
    }

    // MARK: - MoviesListView
    func viewDataDidUpdate() {
        collectionView.reloadData()
        collectionView.setNeedsLayout()
    }

    // MARK: - Private

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            NSLog("Failed to dequeue `MovieCell`")
            return UICollectionViewCell()
        }
        cell.update(item: viewData.items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                   withReuseIdentifier: LoadingSupplementaryView.identifier,
                                                                   for: indexPath)
        return view
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectItem(viewData.items[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == viewData.items.count - 1 {
            DispatchQueue.main.async {
                //! Reloading collection view in this method causes unexpected UI behaviour
                self.viewModel.loadMore()
            }
        }
        (cell as? MovieCell)?.willAppear()
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentWidth = view.bounds.width -
            collectionView.contentInset.left -
            collectionView.contentInset.right -
            self.collectionViewLayout.minimumInteritemSpacing
        var cellSize = CGSize(width: (contentWidth / CGFloat(numberOfCellsInRow)).rounded(.down), height: 0.0)
        cellSize.height = (cellSize.width * 36.0 / 24.0).rounded(.down)
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewData.isLoadingMore ? CGSize(width: 0.0, height: 50.0) : CGSize.zero
    }
}
