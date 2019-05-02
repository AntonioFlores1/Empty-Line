//
//  ShoppingView.swift
//  EmptyLine
//
//  Created by Pursuit on 4/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ShoppingView: UIView {
    let cell = "shoppingListCell"
    
    lazy var shoppingListTableView: UITableView = {
        let tv = UITableView()
        tv.register(ShoppingTableViewCell.self, forCellReuseIdentifier: cell)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var countainerFooter: UIView = {
        let footer = UIView()
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
    }()
 
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x:10,y: 5 ,width:self.frame.width,height: 150))
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
        
    }()
   
    lazy var payButton: UIButton = {
        var payButton = UIButton()
        payButton.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 0.7)
        payButton.setTitle("pay", for: .normal)
        payButton.layer.cornerRadius = payButton.frame.size.width / 2
        payButton.layer.borderColor = UIColor.darkGray.cgColor
        payButton.layer.borderWidth = 1
        payButton.layer.cornerRadius = 20
        payButton.translatesAutoresizingMaskIntoConstraints = false
        return payButton
    }()

    override init(frame: CGRect) {
        super.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.blue,UIColor.init(red: 41, green: 28, blue: 218, alpha: 1).cgColor,UIColor.purple.cgColor,]
        self.layer.addSublayer(gradient)
//        super.init(frame: .zero)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setupConstraints()
    }

    private func setupConstraints() {
        setupTableView()
        setupFooter()
        setupTitleLabel()
        setupPayButton()
    }
    private func setupTableView() {
        addSubview(shoppingListTableView)
        NSLayoutConstraint.activate([
            shoppingListTableView.topAnchor.constraint(equalTo: topAnchor),
            shoppingListTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shoppingListTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shoppingListTableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85) // 0.8
        ])
    }
    
    private func setupFooter() {
        addSubview(countainerFooter)
        NSLayoutConstraint.activate([
            countainerFooter.topAnchor.constraint(equalTo: shoppingListTableView.bottomAnchor),
            countainerFooter.leadingAnchor.constraint(equalTo: leadingAnchor),
            countainerFooter.trailingAnchor.constraint(equalTo: trailingAnchor),
            countainerFooter.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            countainerFooter.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15) // 0.2
        ])
    }
    
    private func setupTitleLabel() {
        countainerFooter.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: countainerFooter.topAnchor, constant: 12), // 12
            titleLabel.leadingAnchor.constraint(equalTo: countainerFooter.leadingAnchor, constant: 12)
        ])
    }
    
    private func setupPayButton(){
        countainerFooter.addSubview(payButton)
        NSLayoutConstraint.activate([
            payButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            payButton.leadingAnchor.constraint(equalTo: countainerFooter.leadingAnchor, constant: 100),
            payButton.trailingAnchor.constraint(equalTo: countainerFooter.trailingAnchor, constant: -100)
        ])
    }
}
