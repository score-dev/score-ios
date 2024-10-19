//
//  SchoolOpenAPIXCTest.swift
//  SchoolOpenAPITests
//
//  Created by sole on 10/19/24.
//

import XCTest
import Moya

final class SchoolOpenAPIXCTest: XCTestCase {
    func test_schoolAPIDTO로_잘_변환되는지() {
        let expectation = self.expectation(description: "request-school-open-api")
        MoyaProvider<SchoolAPITarget>().request(.fetch(page: 1, perPage: 100)) { completion in
            switch completion {
            case .success(let response):
                XCTAssert(200...299 ~= response.statusCode)

                let dtos = try? JSONDecoder().decode(SchoolAPIDTO.self, from: response.data)
                XCTAssert(dtos != nil)

                expectation.fulfill()
            case .failure(_):
                XCTAssert(false)
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
