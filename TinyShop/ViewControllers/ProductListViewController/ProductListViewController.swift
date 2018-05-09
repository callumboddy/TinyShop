//
//  ProductListViewController.swift
//  TinyShop
//
//  Created by Callum Boddy on 08/05/2018.
//

import UIKit

fileprivate let products = [
    Product(name: "Peas", price: 0.95, image: #imageLiteral(resourceName: "peas"), size: "bag"),
    Product(name: "Eggs", price: 2.1, image: #imageLiteral(resourceName: "eggs"), size: "dozen"),
    Product(name: "Milk", price: 1.3, image: #imageLiteral(resourceName: "milk"), size: "bottle"),
    Product(name: "Beans", price: 0.73, image: #imageLiteral(resourceName: "tomato"), size: "can")
]

class ProductListViewController: UIViewController {

    @IBOutlet private var productListCheckoutFooter: ProductListCheckoutFooter!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var productCheckoutFooterBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var editCurrencyButton: UIButton!

    private let basket = Basket()

    private let currencyConverter = CurrencyConversionController(source: .USD, currencies: [.CHF, .GBP, .EUR])

    private var currentCurrency: Currency = .USD
    private var currentRate: Double = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }

    @IBAction func editCurrency(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Currency", message: "Select your currency", preferredStyle: .actionSheet)

        Currency.allValues.forEach { currency in
            let action = UIAlertAction(title: "\(currency.icon) - \(currency.displayName)", style: .default, handler: { (action) in
                self.currencyConverter.value(for: currency) { (rate, error) in
                    if let _ = error {
                        let alert = UIAlertController(title: "Houston, We have a problem", message: "We are having trouble retriving up to date excange rates right now", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }

                    self.currentCurrency = currency
                    self.currentRate = rate
                    DispatchQueue.main.async {
                        self.editCurrencyButton.titleLabel?.text = currency.icon
                        self.reloadData()
                    }
                }
            })
            actionSheet.addAction(action)
        }

        present(actionSheet, animated: true, completion: nil)
    }

    private func reloadData() {
        productCheckoutFooterBottomConstraint.constant = basket.totalQunatity() > 0 ? 0 : -productListCheckoutFooter.frame.size.height

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

        let totalPrice = PriceFormatter.price(self.basket.totalPrice(), to: self.currentCurrency, at: currentRate)
        let state = ProductListCheckoutFooter.State(totalPrice: totalPrice, totalNumberOfItems: self.basket.totalQunatity())
        self.productListCheckoutFooter.render(state: state)
        self.collectionView.reloadData()

    }

}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductListCollectionViewCell else {
            fatalError("shiiitt")
        }

        let product = products[indexPath.row]
        let quantity = basket.quantity(for: product)
        let price = PriceFormatter.price(product.price, to: currentCurrency, at: currentRate)
        let state = ProductListCollectionViewCell.State(title: product.name, subtitle: product.size, image: product.image, price: price, quantity: quantity)
        cell.render(state: state, animated: false)
        cell.delegate = self

        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width - 60


        return CGSize(width: width / 2, height: ProductListCollectionViewCell.height)
    }
}

extension ProductListViewController: ProductListCollectionViewCellDelegate {
    func productListCollectionViewCellDidSelectQuantityIncrease(_ cell: ProductListCollectionViewCell) {
        guard let index = collectionView.indexPath(for: cell)?.row else { return }
        let product = products[index]
        basket.add(product)

        reloadData()
    }

    func productListCollectionViewCellDidSelectQuantityDecrease(_ cell: ProductListCollectionViewCell) {
        guard let index = collectionView.indexPath(for: cell)?.row else { return }
        let product = products[index]
        basket.remove(product)

        reloadData()
    }
}

extension ProductListViewController: ProductListCheckoutFooterDelegate {
    func productListCheckoutFooterDidSelectProceedToCheckout(_: ProductListCheckoutFooter) {

    }
}
