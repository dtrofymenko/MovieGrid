//
//  ConnectivityServiceImp.swift
//  MovieGrid
//
//  Created by Dmytro Trofymenko on 6/11/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation
import Alamofire

class ConnectivityServiceImp: ConnectivityService {
    let manager = NetworkReachabilityManager()
    var isConnected: Bool {
        return manager?.isReachable ?? true
    }
}
