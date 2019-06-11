//
//  ConnectivityService.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/11/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation

protocol ConnectivityService {
    var isConnected: Bool { get }
}

protocol ConnectivityServiceFactory {
    func makeConnectivityService() -> ConnectivityService
}

extension SharedFactory: ConnectivityServiceFactory {
    func makeConnectivityService() -> ConnectivityService {
        return ConnectivityServiceImp()
    }
}
