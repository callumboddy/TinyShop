//
//  Currency.swift
//  TinyShop
//
//  Created by Callum Boddy on 09/05/2018.
//

import Foundation

struct Conversion: Codable {
    let timestamp: TimeInterval
    let source: String
    let quotes: Quotes
}

typealias Quotes = [String: Double]

enum Currency: String {
    case USD
    case GBP
    case CHF
    case EUR

    var displayName: String {
        switch self {
        case .USD:
            return "US Dollars"
        case .GBP:
            return "British Pounds"
        case .CHF:
            return "Swiss Francs"
        case .EUR:
            return "Euros"
        }
    }

    var icon: String {
        switch self {
        case .USD:
            return "🇺🇸"
        case .GBP:
            return "🇬🇧"
        case .CHF:
            return "🇨🇭"
        case .EUR:
            return "🇪🇺"
        }
    }

    var symbol: String {
        switch self {
        case .USD:
            return "$"
        case .GBP:
            return "£"
        case .CHF:
            return "CHF"
        case .EUR:
            return "€"
        }
    }

    static let allValues: [Currency] = [.USD, .GBP, .CHF, .EUR]
}
