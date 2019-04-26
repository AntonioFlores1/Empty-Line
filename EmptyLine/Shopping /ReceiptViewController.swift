//
//  ReceiptViewController.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/26/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {
    
    let receiptView = ReceiptView()
    
    var checkedOutItems = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.receiptView.itemsTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(receiptView)
        receiptView.itemsTableView.delegate = self
        receiptView.itemsTableView.dataSource = self
        fetchCheckOutItemsForReceipt()
    }
    
    
    private func fetchCheckOutItemsForReceipt(){
       checkedOutItems = ShoppingCartDataManager.fetchShoppingCart()
    }
    
    
    

}

extension ReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkedOutItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = receiptView.itemsTableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath) as? ReceiptTableViewCell else { return UITableViewCell()}
        let checkOutItem = checkedOutItems[indexPath.row]
        cell.textLabel?.text = checkOutItem.name
        cell.detailTextLabel?.text = "Price: $\(checkOutItem.price)"
        return cell
    }
    
    
}
