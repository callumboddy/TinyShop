//
//  Product.swift
//  TinyShop
//
//  Created by Callum Boddy on 08/05/2018.
//

import Foundation
import UIKit

struct Product {
    let identifier = UUID()
    let name: String
    let price: Double
    let image: UIImage?
    let size: String

    func displayPrice() -> String {
        return String(format: "%.2f", self.price)
    }
}

let products = [
    Product(name: "Peas", price: 0.95, image: nil, size: "bag"),
    Product(name: "Eggs", price: 2.1, image: nil, size: "dozen"),
    Product(name: "Milk", price: 1.3, image: nil, size: "bottle"),
    Product(name: "Beans", price: 0.73, image: nil, size: "can")
]
