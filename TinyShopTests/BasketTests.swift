//
//  BasketTests.swift
//  TinyShopTests
//
//  Created by Callum Boddy on 08/05/2018.
//

import XCTest
@testable import TinyShop

class BasketTests: XCTestCase {

    var basket: Basket = Basket()

    override func setUp() {
        super.setUp()
        self.basket = Basket()
    }
    
    func testEmptyBasket() {
        let numberOfProductsInBasket = basket.items.count
        XCTAssertEqual(numberOfProductsInBasket, 0)
    }

    func testCanAddProductToBasket() {
        let product = Product(name: "test", price: 12, image: nil, size: "bag")
        basket.add(product)

        let numberOfProductsInBasket = basket.items.count
        XCTAssertEqual(numberOfProductsInBasket, 1)
    }

    func testCanAddMultipleOfAProductToBasket() {
        let product = Product(name: "test", price: 12, image: nil, size: "bag")
        basket.add(product)
        basket.add(product)
        basket.add(product)

        let numberOfProductsInBasket = basket.items.count

        // Still 1 Product but of quantity 3
        XCTAssertEqual(numberOfProductsInBasket, 1)

        let item = basket.items.first!
        XCTAssertEqual(item.quantity, 3)
    }

    func testCanAddMultipleProductsToBasket() {

        let productOne = Product(name: "one", price: 12, image: nil, size: "bag")
        let productTwo = Product(name: "two", price: 15, image: nil, size: "slice")
        let productThree = Product(name: "three", price: 15, image: nil, size: "slice")

        basket.add(productOne)
        basket.add(productTwo)
        basket.add(productOne)
        basket.add(productTwo)
        basket.add(productThree)
        basket.add(productTwo)

        let numberOfProductsInBasket = basket.items.count

        // Still 1 Basket Item but of quantity 3
        XCTAssertEqual(numberOfProductsInBasket, 3)

        let basketItemOne = basket.items.filter { $0.product.identifier == productOne.identifier }.first!
        let basketItemTwo = basket.items.filter { $0.product.identifier == productTwo.identifier }.first!
        let basketItemThree = basket.items.filter { $0.product.identifier == productThree.identifier }.first!

        XCTAssertEqual(basketItemOne.quantity, 2)
        XCTAssertEqual(basketItemTwo.quantity, 3)
        XCTAssertEqual(basketItemThree.quantity, 1)
    }

    func testCanRemoveProductQuantityFromBasket() {
        let product = Product(name: "one", price: 12, image: nil, size: "bag")

        basket.add(product)
        basket.add(product)
        basket.add(product)
        basket.remove(product)

        let item = basket.items.first!
        XCTAssertEqual(item.quantity, 2)
    }

    func testCanRemoveProductFromBasket() {
        let product = Product(name: "one", price: 12, image: nil, size: "bag")

        basket.add(product)
        basket.remove(product)

        let expectation = basket.items.count
        XCTAssertEqual(expectation, 0)
    }

    func testHandlesNilProductBeingRemoved() {
        let product = Product(name: "one", price: 12, image: nil, size: "bag")

        basket.remove(product)

        let expectation = basket.items.count
        XCTAssertEqual(expectation, 0)
    }


    func testCanRemoveAllProductsFromBasket() {
        let productOne = Product(name: "one", price: 12, image: nil, size: "bag")
        let productTwo = Product(name: "two", price: 15, image: nil, size: "slice")
        let productThree = Product(name: "three", price: 15, image: nil, size: "slice")

        basket.add(productOne)
        basket.add(productTwo)
        basket.add(productOne)
        basket.add(productTwo)
        basket.add(productThree)
        basket.add(productTwo)

        basket.removeAll()

        let expectation = basket.items.count
        XCTAssertEqual(expectation, 0)
    }

    func testTotalCalculation() {
        let productOne = Product(name: "one", price: 12, image: nil, size: "bag")
        let productTwo = Product(name: "two", price: 15, image: nil, size: "slice")

        basket.add(productOne)
        basket.add(productTwo)
        basket.add(productTwo)

        let expectation = basket.totalPrice()
        XCTAssertEqual(expectation, 42)
    }

    func testQuantityForProduct() {
        let productOne = Product(name: "one", price: 12, image: nil, size: "bag")

        basket.add(productOne)
        basket.add(productOne)
        basket.add(productOne)
        basket.add(productOne)

        let expectation = basket.quantity(for: productOne)
        XCTAssertEqual(expectation, 4)
    }

    func testPriceForProduct() {
        let productOne = Product(name: "one", price: 12, image: nil, size: "bag")

        basket.add(productOne)
        basket.add(productOne)
        basket.add(productOne)
        basket.add(productOne)

        let expectation = basket.price(for: productOne)
        XCTAssertEqual(expectation, 48)
    }

    func testTotalQuantity() {
        let productOne = Product(name: "one", price: 12, image: nil, size: "bag")
        let productTwo = Product(name: "two", price: 15, image: nil, size: "slice")

        basket.add(productOne)
        basket.add(productOne)
        basket.add(productOne)
        basket.add(productTwo)
        basket.add(productTwo)

        let expectation = basket.totalQunatity()
        XCTAssertEqual(expectation, 5)
    }

    func testPriceForProductButNoProductAvailable() {
        let productOne = Product(name: "one", price: 12, image: nil, size: "bag")
        let expectation = basket.price(for: productOne)
        XCTAssertEqual(expectation, 0)

    }
}
