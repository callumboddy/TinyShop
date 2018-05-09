//
//  Basket.swift
//  TinyShop
//
//  Created by Callum Boddy on 08/05/2018.
//

import Foundation

final class BasketItem: Equatable {
    let product: Product
    var quantity: Int

    init(product: Product) {
        self.product = product
        self.quantity = 1
    }

    static func == (lhs: BasketItem, rhs: BasketItem) -> Bool {
        return lhs.product.identifier == rhs.product.identifier
    }
}

final class Basket {

    private(set) var items: [BasketItem] = []

    func add(_ product: Product) {
        guard let item = self.items.filter({ $0.product.identifier == product.identifier}).first else {
            let newItem = BasketItem(product: product)
            self.items.append(newItem)
            return
        }

        item.quantity += 1
    }

    func remove(_ product: Product) {
        guard let item = items.filter({ $0.product.identifier == product.identifier}).first else {
            return
        }

        item.quantity -= 1

        if let index = items.index(of: item), item.quantity <= 0 {
            items.remove(at: index)
        }
    }

    func removeAll() {
        self.items.removeAll()
    }

    func quantity(for product: Product) -> Int {
        guard let item = items.filter({ $0.product.identifier == product.identifier}).first else { return 0 }
        return item.quantity
    }

    func price(for product: Product) -> Double {
        guard let item = items.filter({ $0.product.identifier == product.identifier}).first else { return 0 }
        return item.product.price * Double(item.quantity)
    }

    func totalPrice() -> Double {
        return items.reduce(0, { (result, item) -> Double in
            return result + (item.product.price * Double(item.quantity))
        })
    }

    func totalQunatity() -> Int {
        return items.reduce(0, { (result, item) -> Int in
            return result + item.quantity
        })
    }


}
