//
//  ProductListCheckoutFooter.swift
//  TinyShop
//
//  Created by Callum Boddy on 09/05/2018.
//

import UIKit

protocol ProductListCheckoutFooterDelegate: class {
    func productListCheckoutFooterDidSelectProceedToCheckout(_: ProductListCheckoutFooter)
}

final class ProductListCheckoutFooter: UIView {
    @IBOutlet var checkoutButton: UIButton!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!

    private weak var delegate: ProductListCheckoutFooterDelegate?
    
    struct State {
        let totalPrice: String
        let totalNumberOfItems: Int
    }

    func render(state: State, animated: Bool = false) {
        self.totalPriceLabel.text = state.totalPrice
        self.quantityLabel.isHidden = state.totalNumberOfItems <= 0
        let plural = state.totalNumberOfItems == 1 ? "item" : "items"
        self.quantityLabel.text = "\(state.totalNumberOfItems) \(plural)"
    }

    override func awakeFromNib() {
        checkoutButton.layer.cornerRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
    }

    @IBAction func proceedToCheckout(_ sender: Any) {
        delegate?.productListCheckoutFooterDidSelectProceedToCheckout(self)
    }
}
