//
//  ProductDetailsView.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import PureLayout

class ProductDetailsView: UIView {

    public lazy var productName: UILabel = {
        
        let productName = UILabel()
        productName.textColor = .white
        productName.text = "Product name"
        productName.font = UIFont.systemFont(ofSize: 16)
        return productName
        
    }()
    
    public lazy var productDetails: UITextView = {
        let productDetails = UITextView()
        productDetails.text = "Product details goes here"
        productDetails.isEditable = false
        productDetails.isSelectable = false
        return productDetails
    }()
    
    public lazy var productNutritionDetails: UITextView = {
        let productNutrition = UITextView()
        productNutrition.text = "Product nutrition goes here"
        productNutrition.isEditable = false
        productNutrition.isSelectable = false
        return productNutrition
    }()
    
    
    lazy var productImage: UIImageView = {
        var imageView = UIImageView()
        imageView = UIImageView(image: UIImage(named: "placeholder"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    public lazy var productPrice: UILabel = {
        let productPrice = UILabel()
        productPrice.text = "price"
        productPrice.textColor = .white
        productPrice.font = UIFont.systemFont(ofSize: 30)
        return productPrice
        
    }()
    /*
    
 */
    
    
    public lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.backgroundColor = .black
        deleteButton.autoSetDimensions(to: CGSize(width: 100.0, height: 80.0))
        deleteButton.layer.borderWidth = 1.0
        deleteButton.layer.borderColor = UIColor.gray.cgColor
        deleteButton.layer.cornerRadius = 38.0
        deleteButton.clipsToBounds = true
        deleteButton.setImage(UIImage.init(named: "icons8-delete_sign_filled"), for: .normal)
        deleteButton.backgroundColor = .red
        return deleteButton
    }()
    
    public lazy var addToCartButton: UIButton = {
        let addToCartButton = UIButton()
        addToCartButton.backgroundColor = .black
        addToCartButton.autoSetDimensions(to: CGSize(width: 100.0, height: 80.0))
        addToCartButton.layer.borderWidth = 1.0
        addToCartButton.layer.borderColor = UIColor.gray.cgColor
        addToCartButton.layer.cornerRadius = 38.0
        addToCartButton.setImage(UIImage.init(named: "icons8-plus_math_filled"), for: .normal)
        addToCartButton.backgroundColor = .green
        return addToCartButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        setConstrains()
    }

    private func setConstrains(){
        setNameConstrains()
        setDetails()
        setPrice()
        setDelete()
        setAddToCart()
        setProductImage()
        productNutrition()
    }
    private func setNameConstrains(){
        addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -5).isActive = true
        productName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        productName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
    }
    private func setDetails(){
        addSubview(productDetails)
        productDetails.translatesAutoresizingMaskIntoConstraints = false
        productDetails.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 10).isActive = true
        productDetails.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
        productDetails.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        productDetails.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func productNutrition() {
        addSubview(productNutritionDetails)
        productNutritionDetails.translatesAutoresizingMaskIntoConstraints = false
        productNutritionDetails.topAnchor.constraint(equalTo: productDetails.bottomAnchor, constant: 5).isActive = true
        productNutritionDetails.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        productNutritionDetails.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        productNutritionDetails.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setProductImage() {
        addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 10).isActive = true
        productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        productImage.trailingAnchor.constraint(equalTo: productDetails.leadingAnchor, constant: -5).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }

    private func setPrice(){
        addSubview(productPrice)
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        productPrice.topAnchor.constraint(equalTo: productDetails.bottomAnchor, constant: 120).isActive = true
        productPrice.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        productPrice.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
  
    }
   
    private func setDelete(){
        
        addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 10).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -250).isActive = true
    }

    private func setAddToCart(){
        addSubview(addToCartButton)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 10).isActive = true
        addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 250).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        
    }
    
    
    
}
