//
//  ShoppingView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ShoppingView: UIView {
 
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x:10,y: 5 ,width:self.frame.width,height: 150))
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    private func commonInit(){
    self.addSubview(titleLabel)
    }
    
    
    
}
