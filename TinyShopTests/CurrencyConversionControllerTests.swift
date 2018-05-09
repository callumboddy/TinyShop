//
//  CurrencyConversionControllerTests.swift
//  TinyShopTests
//
//  Created by Callum Boddy on 09/05/2018.
//

import XCTest
@testable import TinyShop

class CurrencyConversionControllerTests: XCTestCase {
    var currencyConverter: CurrencyConversionController?

    override func setUp() {
        super.setUp()
        self.currencyConverter = CurrencyConversionController(source: .USD, currencies: [.GBP])
    }

    func testReturnsValue() {
        let expectation = XCTestExpectation(description: "request")
        self.currencyConverter?.value(for: .GBP, completion: { (value, error) in
            // TODO: create a mock repsonse. assuming the USD will always be weaker than the pound :joy: for now
            XCTAssertTrue(value < 1)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 10)
    }

    func testDoubleResponse() {
        let expectation1 = XCTestExpectation(description: "first request")
        let expectation2 = XCTestExpectation(description: "second request")
        self.currencyConverter?.value(for: .GBP, completion: { (value, error) in
            XCTAssertTrue(value < 1)
            expectation1.fulfill()
            self.currencyConverter?.value(for: .GBP, completion: { (value, error) in
                XCTAssertTrue(value < 1)
                expectation2.fulfill()
            })
        })

        wait(for: [expectation1, expectation2], timeout: 10)
    }

    func testNotValidCurrency() {
        let expectation = XCTestExpectation(description: "request")
        self.currencyConverter?.value(for: .CHF, completion: { (value, error) in
            XCTAssertEqual(error, .converstionNotAvailable)
            expectation.fulfill()
        })
    }
    
}
