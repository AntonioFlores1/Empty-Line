//
//  ShoppingTableViewCell.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    

    lazy var shoppingListImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = image.frame.width/2
        image.clipsToBounds = true
        return image
    }()
    
    lazy var shoppingLabelDetail: UILabel = {
        let shoppingLabel = UILabel()
        shoppingLabel.textColor = .black
        shoppingLabel.font = UIFont.systemFont(ofSize: 15)
        shoppingLabel.backgroundColor = .white
        return shoppingLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let price = UILabel()
        price.textColor = .black
        price.font = UIFont.systemFont(ofSize: 15)
        price.backgroundColor = .white
        return price
    }()
    
    lazy var addItemButton: UIButton = {
        let addItem = UIButton()
        addItem.addTarget(self, action: #selector(addItemTo), for: .touchUpInside)
        addItem.setImage(UIImage(named: "add"), for: .normal)
        return addItem
    }()
    
    lazy var labelUpdate: UILabel = {
        let update = UILabel()
//        update.backgroundColor = .black
        update.text = "1"
        return update
    }()
    @objc func addItemTo() {
        print("Added !!!!!!!!!!")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setUpViewConstraints()
    }
    
    private func commonInit() {
        setUpViewConstraints()
    }
    
    func setUpViewConstraints() {
        addSubview(shoppingListImage)
        addSubview(shoppingLabelDetail)
        addSubview(priceLabel)
        addSubview(addItemButton)
        addSubview(labelUpdate)
        shoppingListImageConstraints()
        shoppingListLabelConstraints()
        priceLabelConstraints()
        addItemButtonConstrain()
        labelUpdateConstrain()
    }
    func shoppingListImageConstraints() {
        shoppingListImage.translatesAutoresizingMaskIntoConstraints = false
        shoppingListImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        shoppingListImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        shoppingListImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -300).isActive = true
        shoppingListImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        shoppingListImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        shoppingListImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func shoppingListLabelConstraints() {
        shoppingLabelDetail.translatesAutoresizingMaskIntoConstraints = false
        shoppingLabelDetail.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        shoppingLabelDetail.leadingAnchor.constraint(equalTo: shoppingListImage.trailingAnchor, constant: 20).isActive = true
        shoppingLabelDetail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
    func priceLabelConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: shoppingLabelDetail.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: shoppingListImage.trailingAnchor, constant: 20).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
    func addItemButtonConstrain() {
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        addItemButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        addItemButton.leadingAnchor.constraint(equalTo: shoppingListImage.trailingAnchor, constant: 270).isActive = true
        addItemButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        addItemButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    func labelUpdateConstrain() {
        labelUpdate.translatesAutoresizingMaskIntoConstraints = false
        labelUpdate.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        labelUpdate.leadingAnchor.constraint(equalTo: shoppingListImage.trailingAnchor, constant: 275).isActive = true
        labelUpdate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        labelUpdate.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
