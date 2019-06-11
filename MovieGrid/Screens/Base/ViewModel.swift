//
//  ViewModel.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

protocol ModelView: class {}

class ViewModel {
    weak var baseView: ModelView!

    func viewWillAppear(isFirstAppearing: Bool) {}
}
