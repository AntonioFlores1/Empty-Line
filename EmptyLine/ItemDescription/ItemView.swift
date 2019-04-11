//
//  ItemView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ItemView: UIView {

    lazy var itemImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "item"
        label.textColor = .white
        label.backgroundColor = UIColor.black
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "price"
        label.textColor = .white
        label.backgroundColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemImageConstraints() {
        addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
}
