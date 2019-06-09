//
//  ViewController.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private(set) var isFirstAppearing: Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        isFirstAppearing = false
        super.viewDidAppear(animated)
    }
}
