//
//  HistoryDetailTableViewCell.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class HistoryDetailTableViewCell: UITableViewCell {

    
    lazy var historyshoppingListImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = image.frame.width/2
        image.clipsToBounds = true
        return image
    }()
    
    lazy var historyLabelDetail: UILabel = {
        let shoppingLabel = UILabel()
        shoppingLabel.textColor = .black
        shoppingLabel.font = UIFont.systemFont(ofSize: 15)
        shoppingLabel.backgroundColor = .white
        return shoppingLabel
    }()
    
    lazy var historypriceLabel: UILabel = {
        let price = UILabel()
        price.textColor = .black
        price.font = UIFont.systemFont(ofSize: 15)
        price.backgroundColor = .white
        return price
    }()
    
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
        addSubview(historyshoppingListImage)
        addSubview(historyLabelDetail)
        addSubview(historypriceLabel)
        shoppingListImageConstraints()
        shoppingListLabelConstraints()
        priceLabelConstraints()
    }
    func shoppingListImageConstraints() {
        historyshoppingListImage.translatesAutoresizingMaskIntoConstraints = false
        historyshoppingListImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        historyshoppingListImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        historyshoppingListImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -300).isActive = true
        historyshoppingListImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        historyshoppingListImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        historyshoppingListImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func shoppingListLabelConstraints() {
        historyLabelDetail.translatesAutoresizingMaskIntoConstraints = false
        historyLabelDetail.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        historyLabelDetail.leadingAnchor.constraint(equalTo: historyshoppingListImage.trailingAnchor, constant: 20).isActive = true
        historyLabelDetail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
    func priceLabelConstraints() {
        historypriceLabel.translatesAutoresizingMaskIntoConstraints = false
        historypriceLabel.topAnchor.constraint(equalTo: historyLabelDetail.bottomAnchor, constant: 5).isActive = true
        historypriceLabel.leadingAnchor.constraint(equalTo: historyshoppingListImage.trailingAnchor, constant: 20).isActive = true
        historypriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }

}
