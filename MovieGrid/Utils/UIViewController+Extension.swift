//
//  UIViewController+Extension.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiateFromStoryboard<T: UIViewController>(type: T.Type, storyboardName: String? = nil) -> T? {
        let storyboardName = storyboardName ?? String(describing: type).replacingOccurrences(of: "Controller", with: "")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            NSLog("Failed to initialize `\(type)`")
            return nil
        }
        return viewController
    }
}
