//
//  CreditCardInfoSetupViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreditCardInfoSetupViewController: UITableViewController {
    @IBOutlet weak var CardTypeLabel: UILabel!
    @IBOutlet weak var CardOptionsLabel: UILabel!
    @IBOutlet weak var PayPalLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var streetNameTextField: UITextField!
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var stateNameTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = .purple
       
    }
    
    @IBAction func ScanCardButtonPressed(_ sender: UIButton) {
    }
    

}


