//
//  ProductDetailViewController.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var productDetailView = ProductDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productDetailView)
        dismissButton()
     
    }
    func dismissButton() {
        productDetailView.deleteButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }
    
    @objc private func dismissButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
}
