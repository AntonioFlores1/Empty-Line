//
//  ShoppingTableViewCell.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
//protocol AddItemCellDelegate: AnyObject{
//    func addItemTo()
//}

class ShoppingTableViewCell: UITableViewCell {
//    weak var delegate: AddItemCellDelegate?
    
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
    
    lazy var addItemStepper: UIStepper = {
        var customStepper = UIStepper.init(frame: CGRect(x: 150,y: 150,width: 100,height: 100))
        customStepper.minimumValue = -1
        customStepper.maximumValue = 1
        return customStepper
    }()
    
    lazy var labelUpdate: UILabel = {
        let update = UILabel()
        update.text = "1"
        return update
    }()
    @objc func addItemTo(_ sender: UIStepper) {
        var total = 0
        if addItemStepper.value == 2.0{
            total += 1
        } else if addItemStepper.value == 0 {
            total -= 1
        }
        
        addItemStepper.value = 0
        labelUpdate.text = total.description
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
        addSubview(addItemStepper)
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
        addItemStepper.translatesAutoresizingMaskIntoConstraints = false
        addItemStepper.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        addItemStepper.leadingAnchor.constraint(equalTo: shoppingListImage.trailingAnchor, constant: 200).isActive = true
        addItemStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        addItemStepper.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    func labelUpdateConstrain() {
        labelUpdate.translatesAutoresizingMaskIntoConstraints = false
        labelUpdate.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        labelUpdate.leadingAnchor.constraint(equalTo: shoppingListImage.trailingAnchor, constant: 270).isActive = true
        labelUpdate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        labelUpdate.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
