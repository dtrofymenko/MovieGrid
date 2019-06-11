//
//  ConnectivityServiceMock.swift
//  MovieGridTests
//
//  Created by Dmytro Trofymenko on 6/11/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation
@testable import MovieGrid

class ConnectivityServiceMock: ConnectivityService {
    var isConnected: Bool = true
}
