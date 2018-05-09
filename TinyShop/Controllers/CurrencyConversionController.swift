//
//  CurrencyConversionController.swift
//  TinyShop
//
//  Created by Callum Boddy on 09/05/2018.
//

import Foundation


enum CurrencyConversionError: Error {
    case converstionNotAvailable
}

class CurrencyConversionController {

    // MARK: Properties

    private var urlComponents: URLComponents
    private let source: Currency
    private let currencies: [Currency]

    private(set) var quotes: Quotes?

    // MARK: Initializers

    init(source: Currency, currencies: [Currency]) {
        self.urlComponents = URLComponents()
        self.source = source
        let availableCurrencies = currencies + [source]
        self.currencies = availableCurrencies
    }

    // MARK: Public Methods

    func value(for currency: Currency, completion: @escaping (Double, CurrencyConversionError?) -> Void) {

        // ensure this instace is capable of the required conversion
        guard currencies.contains(currency) else {
            completion(1, .converstionNotAvailable)
            return
        }

        // if we have quotes cached already, unwrap and check we have currency
        if let quotes = quotes {
            let requestedCurrency = "\(source)\(currency)"
            if let requestedValue = quotes[requestedCurrency] {
                completion(requestedValue, nil)
                return
            }
            completion(1, .converstionNotAvailable)

            // else make the request & then return the value on request completion
        } else {
            self.request { (conversion, error) in

                // we made a successful request - lets check for the value now
                if let _ = self.quotes {
                    self.value(for: currency, completion: completion)

                    // unable to make a successful request to the api at this time
                } else {
                    completion(1, .converstionNotAvailable)
                }
            }
        }
    }

    // MARK: Private Methods

    private func request(completion: @escaping (Conversion?, Error?) -> Void) {
        urlComponents.scheme = "http"
        urlComponents.host = "apilayer.net"
        urlComponents.path = "/api/live"

        let accessKeyQuery = URLQueryItem(name: "access_key", value: Configuration.accessKey)
        let formatQuery = URLQueryItem(name: "format", value: "1")
        let currencyString = currencies.map { $0.rawValue }.joined(separator: ",")
        let currencyQuery = URLQueryItem(name: "currencies", value: currencyString)

        urlComponents.queryItems = [accessKeyQuery, formatQuery, currencyQuery]

        let urlRequest = URLRequest(url: urlComponents.url!)


        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let conversion = try? JSONDecoder().decode(Conversion.self, from: data!)
            self.quotes = conversion?.quotes
            completion(conversion, error)
        }.resume()
    }
}

