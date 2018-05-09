//
//  PriceFormatter.swift
//  TinyShop
//
//  Created by Callum Boddy on 09/05/2018.
//

import Foundation

class PriceFormatter {

    static func price(_ price: Double, to currency: Currency, at rate: Double) -> String {
        let convertedPrice = price * rate
        return String(format: "%@%.2f", currency.symbol, convertedPrice)
    }
}
