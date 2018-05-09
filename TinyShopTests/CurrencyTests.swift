//
//  CurrencyTests.swift
//  TinyShopTests
//
//  Created by Callum Boddy on 09/05/2018.
//

import XCTest
@testable import TinyShop

class CurrencyTests: XCTestCase {

    func testUSD() {
        let currency: Currency = .USD

        XCTAssertEqual(currency.displayName, "US Dollars")
        XCTAssertEqual(currency.icon, "🇺🇸")
        XCTAssertEqual(currency.symbol, "$")
    }

    func testEuros() {
        let currency: Currency = .EUR

        XCTAssertEqual(currency.displayName, "Euros")
        XCTAssertEqual(currency.icon, "🇪🇺")
        XCTAssertEqual(currency.symbol, "€")
    }

    func testBritishPounds() {
        let currency: Currency = .GBP

        XCTAssertEqual(currency.displayName, "British Pounds")
        XCTAssertEqual(currency.icon, "🇬🇧")
        XCTAssertEqual(currency.symbol, "£")
    }

    func testSwissFrancs() {
        let currency: Currency = .CHF

        XCTAssertEqual(currency.displayName, "Swiss Francs")
        XCTAssertEqual(currency.icon, "🇨🇭")
        XCTAssertEqual(currency.symbol, "CHF ")
    }

    
}
