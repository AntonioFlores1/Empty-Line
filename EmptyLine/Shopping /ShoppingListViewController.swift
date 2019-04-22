//
//  ShoppingListViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase
import Stripe


class ShoppingListViewController: UIViewController {
    static var total = 0.0
    var itemsPriceTotal: Double = 0.0 {
        didSet {
            shoppingView.titleLabel.text  = "Total Amount : \(itemsPriceTotal)"
          
        }
    }


    var productDetailView = ProductDetailsView()
    public var items: Item!
    private var shoppingView = ShoppingView()
    private var listener: ListenerRegistration!
    private let authservice = AppDelegate.authservice
    private var barButtonItem = UIBarButtonItem()
    var shoppingImage = UIImage()
    
    private var shoppingListTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    private lazy var refresh: UIRefreshControl = {
        let refC = UIRefreshControl()
        shoppingListTableView.refreshControl = refC
        refC.addTarget(self, action: #selector(fetchShoppingCartItems), for: .valueChanged)
        return refC
    }()
    private var shoppingCart = [Item](){
        didSet {
            DispatchQueue.main.async {
                self.shoppingListTableView.reloadData()
                self.shoppingView.titleLabel.resignFirstResponder()
        }
      }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shoppingView)
        view.backgroundColor = .white
        navigationItem.title = "Checkout List"
        shoppingListTableView.reloadData()
        shoppingListTableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        shoppingListTableView.delegate      =   self
        shoppingListTableView.dataSource    =   self
        fetchShoppingCartItems()
        self.itemsPriceTotal = ItemsDataManager.totalAmount()
        shoppingListTableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: "cell")
        barButtonItem = UIBarButtonItem(title: "Pay", style: .done, target: self, action: #selector(barButtonPressed))
        navigationItem.rightBarButtonItem = barButtonItem
        self.view.addSubview(self.shoppingListTableView)
        shoppingListTableView.tableFooterView = shoppingView
    }
    
    @objc private func fetchShoppingCartItems(){
        shoppingCart = ItemsDataManager.fetchShoppingCart()
        refresh.beginRefreshing()
    }
    @objc func barButtonPressed() {
        //navigationController?.pushViewController(ConfirmPaymentViewController(), animated: true)
        
        let addCardController = STPAddCardViewController()
        addCardController.delegate = self
        let navigationController = UINavigationController(rootViewController: addCardController)
        present(navigationController, animated: true, completion: nil)
    }
    
   
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell()}
        
        let itemInCart = shoppingCart[indexPath.row]
        cell.shoppingLabelDetail.text = itemInCart.name
        cell.priceLabel.text = "$" + " \(itemInCart.price)"
        cell.shoppingListImage.kf.setImage(with: URL(string: itemInCart.image))
        refresh.endRefreshing()
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 1.0
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.5
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.shoppingCart.remove(at: indexPath.row)
            self.shoppingListTableView.deleteRows(at: [indexPath], with: .automatic)
            ItemsDataManager.deleteFromShoppingCart(index: indexPath.row)
            self.itemsPriceTotal = ItemsDataManager.totalAmount()
          
        }
    }

}

extension ShoppingListViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        dismiss(animated: true, completion: nil)
        showAlert(title: "\(authservice.getCurrentUser()?.displayName ?? "") Your transaction was success", message: "Thank you for shopping with zipLine")
        itemsPriceTotal = 0.0
        shoppingCart.removeAll()
        barButtonItem.isEnabled = false
    }
}
