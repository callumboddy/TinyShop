//
//  ProductTests.swift
//  TinyShopTests
//
//  Created by Callum Boddy on 08/05/2018.
//

import XCTest
@testable import TinyShop

class ProductTests: XCTestCase {

    func testProduct() {
        let product = Product(name: "Ice Cream", price: 2.30, image: nil, size: "scoop")

        XCTAssertEqual(product.name, "Ice Cream")
        XCTAssertEqual(product.price, 2.30)
        XCTAssertNil(product.image)
        XCTAssertEqual(product.size, "scoop")
    }

    func testDisplayPrice() {
        let noDecimal = Product(name: "Ham", price: 10, image: nil, size: "slice")
        let sinlgeDecimal = Product(name: "Sugar", price: 1.5, image: nil, size: "bag")
        let twoDecimal = Product(name: "Ice Cream", price: 2.30, image: nil, size: "scoop")
        let manyDecimal = Product(name: "Chilli", price: 2.812387, image: nil, size: "each")

        XCTAssertEqual(noDecimal.displayPrice(), "10.00")
        XCTAssertEqual(sinlgeDecimal.displayPrice(), "1.50")
        XCTAssertEqual(twoDecimal.displayPrice(), "2.30")
        XCTAssertEqual(manyDecimal.displayPrice(), "2.81")

    }
}
