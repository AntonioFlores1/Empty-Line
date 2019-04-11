//
//  ShoppingListViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Kingfisher

class ShoppingListViewController: UIViewController {
   
    private var shoppingListTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    private var shoppingView = ShoppingView()
    private let authservice = AppDelegate.authservice
    private var barButtonItem = UIBarButtonItem()
    var animals : [String] = ["Dogs","Cats","Mice"]
    let price : [String] = ["$5","$12","$30"]
    var shoppingImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Checkout List"
        shoppingListTableView.reloadData()
        shoppingListTableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        shoppingListTableView.delegate      =   self
        shoppingListTableView.dataSource    =   self
        shoppingListTableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: "cell")
        barButtonItem = UIBarButtonItem(title: "Pay", style: .done, target: self, action: #selector(barButtonPressed))
        navigationItem.rightBarButtonItem = barButtonItem
//        secondbarButtonItem = UIBarButtonItem(title: "Pay", style: .done, target: self, action: #selector(secondBarButtonPressed))
//        navigationItem.rightBarButtonItem = secondbarButtonItem
        self.view.addSubview(self.shoppingListTableView)
    }
    @objc func barButtonPressed() {
        print("Pay in on the way")
        navigationController?.pushViewController(ConfirmPaymentViewController(), animated: true)
    }
//    @objc func secondBarButtonPressed() {
//        
//    }
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell()}
        cell.shoppingLabelDetail.text = animals[indexPath.row]
        cell.priceLabel.text = price[indexPath.row]
        cell.shoppingListImage.image = UIImage(named: "placeholder")
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.animals.remove(at: indexPath.row)
            self.shoppingListTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
