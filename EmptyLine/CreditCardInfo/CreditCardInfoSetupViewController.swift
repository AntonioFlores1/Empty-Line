//
//  CreditCardInfoSetupViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreditCardInfoSetupViewController: UITableViewController {
    
    var titles = ["PAYMENT METHOD", "BILLING NAME","CARD INFORMATION", "BILLING ADDRESS"]
    
    
    var barButtonItem = UIBarButtonItem()
    
    let creditCardView = CreditCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        view.addSubview(creditCardView)
        creditCardView.creditCardCredentialsTableView.delegate = self
        creditCardView.creditCardCredentialsTableView.dataSource = self
       setupBarButtonItem()
        
        }
    
    private func setupBarButtonItem(){
        view.backgroundColor = .white
        navigationItem.title = "PAYMENT SETTINGS"
        barButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(barButtonPressed))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func barButtonPressed(){
        // Save updates to fire base
        barButtonItem.isEnabled = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = titles[section]
        return title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
      }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = creditCardView.creditCardCredentialsTableView.dequeueReusableCell(withIdentifier: "CCTableViewCell", for: indexPath) as? CardTypeTableViewCell else {return UITableViewCell()}
            return cell
        case 1:
            guard let nameCell = creditCardView.creditCardCredentialsTableView.dequeueReusableCell(withIdentifier: "BillingNameCell", for: indexPath) as? BillingNameTableViewCell else {return UITableViewCell()}
            return nameCell
            
        case 2:
            guard let cardInfoCell = creditCardView.creditCardCredentialsTableView.dequeueReusableCell(withIdentifier: "CardInfoCell", for: indexPath) as? CardInfoTableViewCell else {return UITableViewCell()}
            return cardInfoCell
            
        
        case 3:
            guard let billingAddressCell = creditCardView.creditCardCredentialsTableView.dequeueReusableCell(withIdentifier: "BillingAddressCell", for: indexPath) as? BillingAddressInfoTableViewCell else {return UITableViewCell()}
            return billingAddressCell
            
        default:
            return UITableViewCell()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 1:
             return 120
        case 2:
             return 160
        case 3:
             return 200
        default:
            return 0
        }
        }
}
