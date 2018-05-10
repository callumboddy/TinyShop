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

    /// The base currency to compare other currencies against
    private let source: Currency


    /// The array of currencies that this instance is able to compare against
    private let currencies: [Currency]


    /// The set of values that represent the exchange rates for each currency.
    private(set) var quotes: Quotes?

    /// creates an instance of a currency converter object given a base currency & an array of target currencies
    ///
    /// - Parameters:
    ///   - source: the base currency to compare against
    ///   - currencies: an array of other currencies that you wish to get the exchange rate for.
    init(source: Currency, currencies: [Currency]) {
        self.source = source
        let availableCurrencies = currencies + [source]
        self.currencies = availableCurrencies
    }


    /// retrieves the exchange rate value for a particular currency against the instances base currency.
    ///
    /// - Parameters:
    ///   - currency: the currency you wish to get th exchange rate for
    ///   - completion: returns the value of the exhange rate & an error.
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

    // TODO: Networking is tightly coupled to this object - to keep it lean, as it is the only required networking for now. Look to abstract this into a more generic networking stack.

    private func request(completion: @escaping (Conversion?, Error?) -> Void) {
        var urlComponents: URLComponents = URLComponents()

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
            guard let data = data, let conversion = try? JSONDecoder().decode(Conversion.self, from: data) else {
                completion(nil, error)
                return
            }

            self.quotes = conversion.quotes
            completion(conversion, error)
        }.resume()
    }
}

