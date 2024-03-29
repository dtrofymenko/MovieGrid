//
//  ModelViewController.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class ModelViewController<VM: ViewModel>: ViewController, ModelView {
    var viewModel: VM! {
        didSet {
            viewModel.baseView = self
        }
    }

    class func instantiateFromStoryboard(viewModel: VM, storyboardName: String? = nil) -> Self? {
        let viewController = UIViewController.instantiateFromStoryboard(type: self, storyboardName: storyboardName)
        viewController?.viewModel = viewModel
        return viewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear(isFirstAppearing: isFirstAppearing)
    }
}
