//
//  ProductDetailViewController.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMLVision

class ProductDetailViewController: UIViewController {
    
    var productDetailView = ProductDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
}

//
//    private var productDetailView = ProductDetailsView()
//    private var products:Item?
//    private var barCodeNumber: String!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(productDetailView)
//        dismissButton()
//        setupView()
//        fetchProduct(barCode: "04965802")
//        addToShoppingCart()
//    }
//    func dismissButton() {
//        productDetailView.deleteButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
//    }
//
//    @objc private func dismissButtonPressed(){
//        dismiss(animated: true, completion: nil)
//    }
//
//
//    public func setupView(){
//
//        if let window = UIApplication.shared.keyWindow {
//            view.backgroundColor = UIColor(white: 0, alpha: 0.5)
//            view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleDismiss)))
//            window.addSubview(productDetailView)
//
//
//            let height: CGFloat = 300
//
//            let y = window.frame.height - height
//
//            view.frame = window.frame
//            view.alpha = 0
//
//           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//
//                self.view.alpha = 1
//                self.productDetailView.frame = CGRect(x: 0, y: y, width: self.productDetailView.frame.width, height: self.productDetailView.frame.height)
//
//            }, completion: nil)
//
//        }
//    }
//
//    @objc func handleDismiss() {
//
//        UIView.animate(withDuration: 0.5) {
//
//            self.view.alpha = 0
//            if let window = UIApplication.shared.keyWindow {
//
//                self.productDetailView.frame = CGRect(x: 0, y: window.frame.height, width: self.productDetailView.frame.width, height: self.productDetailView.frame.height)
//            }
//        }
//    }
//
//
//
//    private func fetchProduct(barCode: String){
//        DBService.getProducts(productBarcode: barCode) { (error, product) in
//            if let error = error {
//                self.showAlert(title: "Error fetching product information", message: error.localizedDescription)
//            } else {
//                if let product = product {
//                    self.products = product
//                    dump(self.products)
//
//                    self.productDetailView.productName.text = product.name
//                    self.productDetailView.productDetails.text = product.description
//                    self.productDetailView.productPrice.text = "$" + String(product.price)
//                    self.productDetailView.productImage.kf.setImage(with: URL(string: product.image))
//                }
//            }
//        }
//    }
//
//    private func addToShoppingCart(){
//        productDetailView.addToCartButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
//
//
//    }
//
//    @objc private func addButtonPressed(){
//        if let item = products {
//            ItemsDataManager.addToShoppingCart(item: item)
//            navigationController?.present(ShoppingListViewController(), animated: true, completion: nil)
//            print("Item added")
//
//        }
//    }

