//
//  DetailsLauncher.swift
//  EmptyLine
//
//  Created by Alfredo Barragan on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMLVision

class DetailsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var products:Item?

    var barcodeNumber: String!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        return cell
        
    }
    
    let cellID = "DetailsCell"
    let productDetailsView = ProductDetailsView()
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    
    
    private func fetchProducts(barCode: String){
        DBService.getProducts(productBarcode: barCode) { (error, product) in
            if let error = error {
                // self.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                if let product = product {
                    self.products = product
                    dump(self.products)
                    self.productDetailsView.productName.text = product.name
                    self.productDetailsView.productDetails.text = product.description
                    self.productDetailsView.productPrice.text = "$" + String(product.price)
                    self.productDetailsView.productImage.kf.setImage(with: URL(string: product.image))
                }
                
            }
            
        }
        
    }
    
    private func addToShoppingCart(){
        productDetailsView.addToCartButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        print("KKKKKKKk")
        
    }
    
    @objc private func addButtonPressed(){
        if let item = products {
            ItemsDataManager.addToShoppingCart(item: item)
           
         
        }
    }
    
    
    
    
//    private func getProduct() {
//        DBService.getProducts(productBarcode: products?.barcode ?? "") { (error, item) in
//            if let error = error {
//                print("Error Error")
//            } else if let item = item {
//                self.barcodeNumber = item.barcode
//                print(self.barcodeNumber)
//            }
//        }
//    }

    //    private func setupDetailsView(){
    
    //
    
    //
    
    //
    
    //    }
    func showSettings() {
        
        //show menu
 
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(productDetailsView)
            
            
            
            let height: CGFloat = 300
            
            let y = window.frame.height - height
            
            // collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            
            
            blackView.frame = window.frame
            
            blackView.alpha = 0
            
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                
                
                self.blackView.alpha = 1
                
                
                
                self.productDetailsView.frame = CGRect(x: 0, y: y, width: self.productDetailsView.frame.width, height: self.productDetailsView.frame.height)
                
                
                
            }, completion: nil)
            
        }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            
            return cell
            
        }
    }
    
    
    
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                
                self.productDetailsView.frame = CGRect(x: 0, y: window.frame.height, width: self.productDetailsView.frame.width, height: self.productDetailsView.frame.height)
            }
        }
    }
    override init() {
        super.init()
        print("06827465")
        fetchProducts(barCode:"04965802")
        
        //setupDetailsView()
        collectionView.delegate = self
        collectionView.dataSource = self
        addToShoppingCart()
    }
}
