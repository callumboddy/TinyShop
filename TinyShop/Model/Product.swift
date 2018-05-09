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
}
