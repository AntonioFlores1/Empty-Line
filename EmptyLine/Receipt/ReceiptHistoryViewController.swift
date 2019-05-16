//
//  ReceiptHistoryViewController.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 5/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ReceiptHistoryViewController: UIViewController {

    let receiptHistoryView = ReceiptHistoryView()
    
    private var allCheckedOutItems = [Item](){
        didSet {
            DispatchQueue.main.async {
                self.receiptHistoryView.itemsTableView.reloadData()
            }
        }
    }
    
    private var totalCost = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(receiptHistoryView)
        receiptHistoryView.itemsTableView.dataSource =  self
        receiptHistoryView.itemsTableView.delegate = self
         view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        receiptHistoryView.storeName.text = "SERVED BY:   Whole Foods Market"
        receiptHistoryView.itemsTableView.separatorStyle = .none

    }
    
    
    init(allItemsCheckedOutByDay: [Item]){
        super.init(nibName: nil, bundle: nil)
        self.allCheckedOutItems = allItemsCheckedOutByDay
        
    }
    
    required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
    }
    }
    


extension ReceiptHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCheckedOutItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemsCell = receiptHistoryView.itemsTableView.dequeueReusableCell(withIdentifier: "receiptHistory", for: indexPath) as? ReceiptHistoryTableViewCell else {return UITableViewCell()}
        
        let itemBoughtOnDay = allCheckedOutItems[indexPath.row]
        receiptHistoryView.totalCostLabel.text = "Total: $\(totalCost)"
        itemsCell.itemNameLabel.text = itemBoughtOnDay.name
        itemsCell.itemPrice.text = "$" + "\(itemBoughtOnDay.price)"
        receiptHistoryView.dayLabel.text = "----\(itemBoughtOnDay.boughtDate) ----"
        return itemsCell
    }
    
    
}
