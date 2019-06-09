//
//  CommonError.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

enum CustomError: LocalizedError {
    case unknownError

    var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Something went wrong", comment: "")
        }
    }

}
