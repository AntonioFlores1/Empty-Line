//
//  DetailCell.swift
//  EmptyLine
//
//  Created by Alfredo Barragan on 4/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of item"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price of item"
        return label
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "item")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
}
