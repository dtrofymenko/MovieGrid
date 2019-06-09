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
        service = MoviesServiceImp(apiKey: "dummy_key")
    }


    func test_success() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("movie_now_playing.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }

        let expecta = expectation(description: "expectation")
        service.loadMovies(page: 2) { result in
            guard let model = try? result.get() else {
                XCTAssertTrue(false)
                return
            }
            XCTAssertTrue(Thread.current.isMainThread)
            XCTAssertTrue(20 == model.results.count)
            XCTAssertTrue(2 == model.page)
            XCTAssertTrue(50 == model.totalPages)
            expecta.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)

    }
}
