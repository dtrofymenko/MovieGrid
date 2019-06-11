//
//  MoviewGridTests.swift
//  MoviewGridTests
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MoviewGrid

class MoviewGridTests: XCTestCase, ConnectivityServiceFactory {
    override func setUp() {
        connectivityServiceMock = ConnectivityServiceMock()
    }

    override func tearDown() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "")
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: - ConnectivityServiceFactory
    var connectivityServiceMock: ConnectivityServiceMock!
    func makeConnectivityService() -> ConnectivityService {
        return connectivityServiceMock
    }
}
