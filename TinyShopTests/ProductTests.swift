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
}
