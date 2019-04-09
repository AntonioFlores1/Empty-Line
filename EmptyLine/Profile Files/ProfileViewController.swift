//
//  ProfileViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Payment Ray", style: .done, target: self, action: #selector(segueforRaymond))
        // Do any additional setup after loading the view.
    }
    
    @objc func segueforRaymond(){
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let creditCardInfoSetupVC = storyboard.instantiateViewController(withIdentifier: "CreditCardInfoSetupViewController")
        
        let cv = CreditCardInfoSetupViewController()
navigationController?.pushViewController(cv, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
