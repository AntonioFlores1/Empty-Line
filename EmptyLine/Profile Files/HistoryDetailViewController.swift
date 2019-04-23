//
//  HistoryDetailViewController.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
     var newArray = ["Monday - 04/15/19","Monday - 04/15/19","Monday - 04/15/19","Monday - 04/15/19","Monday - 04/15/19","Monday - 04/15/19"]
    
    private var shoppingHistory = [Item](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
//                self.tableView.titleLabel.resignFirstResponder()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "History"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableViewconstriant()
        tableView.reloadData()
    }
    func tableViewconstriant() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    @objc private func fetchShoppingCartItems(){
        shoppingHistory = ShoppingHistoryItemsDataManager.fetchShoppingCart()
//        refresh.beginRefreshing()
    }
}
extension HistoryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryDetailTableViewCell else { return UITableViewCell()}
        let itemInCart = shoppingHistory[indexPath.row]
        cell.historyLabelDetail.text = itemInCart.name
        cell.historypriceLabel.text = "\(itemInCart.price)"
//        cell.historyshoppingListImage.image = UIImage(named: "placeholder")
        cell.historyshoppingListImage.kf.setImage(with: URL(string: itemInCart.image))
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 1.0
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.5
        return cell
    }
}
