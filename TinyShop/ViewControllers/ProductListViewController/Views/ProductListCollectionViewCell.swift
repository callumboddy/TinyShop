//
//  ProductListCollectionViewCell.swift
//  TinyShop
//
//  Created by Callum Boddy on 09/05/2018.
//

import UIKit

protocol ProductListCollectionViewCellDelegate: class {
    func productListCollectionViewCellDidSelectQuantityIncrease(_ cell: ProductListCollectionViewCell)
    func productListCollectionViewCellDidSelectQuantityDecrease(_ cell: ProductListCollectionViewCell)
}

class ProductListCollectionViewCell: UICollectionViewCell {

    // MARK: Properties

    static let reuseIdentifier = "ProductListCollectionViewCell"
    static let height: CGFloat = 296

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var productImageView: UIImageView!
    @IBOutlet private var quantityLabel: UILabel!
    @IBOutlet private var basketButton: UIButton!

    weak var delegate: ProductListCollectionViewCellDelegate?

    struct State {
        let title: String
        let subtitle: String
        let image: UIImage?
        let price: String
        let quantity: Int

        static let empty = State(title: "", subtitle: "", image: nil, price: "", quantity: 0)
    }

    // MARK: Lifecycle

    override func awakeFromNib() {
        layer.cornerRadius = 2
        basketButton.layer.cornerRadius = 2
    }

    func render(state: State, animated: Bool) {
        titleLabel.text = state.title
        subtitleLabel.text = state.subtitle
        priceLabel.text = state.price
        productImageView.image = state.image
        basketButton.isHidden = state.quantity > 0
        quantityLabel.text = "\(state.quantity)"
    }

    // MARK: Actions

    @IBAction func addToBasket(_ sender: Any) {
        delegate?.productListCollectionViewCellDidSelectQuantityIncrease(self)
    }

    @IBAction func increaseQuantity(_ sender: Any) {
        delegate?.productListCollectionViewCellDidSelectQuantityIncrease(self)
    }

    @IBAction func decreaseQuantity(_ sender: Any) {
        delegate?.productListCollectionViewCellDidSelectQuantityDecrease(self)
    }
}
