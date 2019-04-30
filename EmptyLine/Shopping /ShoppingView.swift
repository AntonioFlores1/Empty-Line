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
    
    public lazy var payButton: UIButton = {
        let payButton = UIButton()
        payButton.setTitle("Pay", for: .normal)
        payButton.layer.cornerRadius = 10.0
        return payButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.blue,UIColor.init(red: 41, green: 28, blue: 218, alpha: 1).cgColor,UIColor.purple.cgColor,]
        self.layer.addSublayer(gradient)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    private func commonInit(){
    self.addSubview(titleLabel)
        setConstrains()
    }
    
    
    private func setConstrains(){
        
        addSubview(payButton)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100).isActive = true
        payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100).isActive = true
        payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        payButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    }
    
    
    
}
