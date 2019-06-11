//
//  MoviesServiceTests.swift
//  MoviewGridTests
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs
@testable import MoviewGrid

class MoviesServiceTests: MoviewGridTests {
    var service: MoviesServiceImp!

    override func setUp() {
        super.setUp()
        service = MoviesServiceImp(apiKey: "dummy_key", factory: self)
    }

    func test_success() {
        stubResponse()

        let expecta = expectation(description: "expectation")
        service.loadMovies(page: 1) { result in
            guard let model = try? result.get() else {
                XCTAssertTrue(false)
                return
            }
            XCTAssertTrue(Thread.current.isMainThread)
            XCTAssertTrue(20 == model.results.count)
            XCTAssertTrue(1 == model.page)
            XCTAssertTrue(50 == model.totalPages)
            expecta.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)

    }

    func test_cache() {
        stubResponse()
        var expecta = expectation(description: "expectation")
        service.loadMovies(page: 1) { result in
            expecta.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)

        connectivityServiceMock.isConnected = false
        expecta = expectation(description: "expectation")
        service.loadMovies(page: 1) { result in
            switch result {
            case .success: break
            case .failure:
                XCTAssertTrue(false)
            }
            expecta.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)

        expecta = expectation(description: "expectation")
        service.loadMovies(page: 2) { result in
            switch result {
            case .success:
                XCTAssertTrue(false)
            case .failure: break
            }
            expecta.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK - Private
    private func stubResponse() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("movie_now_playing.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
}
