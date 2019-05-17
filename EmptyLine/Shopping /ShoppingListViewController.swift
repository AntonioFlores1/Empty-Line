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
    
    var total = 0.0
    var totalItems = 1
    
    var previousValue = 1

    private var activityView: UIActivityIndicatorView!
    var productDetailView = ProductDetailsView()
    private var product:NumberOfItem?
    private var shoppingView = ShoppingView()
    private var listener: ListenerRegistration!
    private let authservice = AppDelegate.authservice
    private var barButtonItem = UIBarButtonItem()
    var shoppingImage = UIImage()
    var stepperTags = [Int]()
    
    private lazy var refresh: UIRefreshControl = {
        let refC = UIRefreshControl()
        shoppingView.shoppingListTableView.refreshControl = refC
        refC.addTarget(self, action: #selector(fetchShoppingCartItems), for: .valueChanged)
        return refC
    }()

    private func updateViews () {
        DispatchQueue.main.async {
            self.shoppingView.shoppingListTableView.reloadData()
            self.shoppingView.titleLabel.text = "Total : $ \(ShoppingCartDataManager.cartTotal())"
            self.shoppingView.taxLabel.text = "Tax :   $ \(ShoppingCartDataManager.totalTax())"
            print(ShoppingCartDataManager.totalTax())
            self.shoppingView.titleLabel.resignFirstResponder()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red:0.29, green:0.60, blue:0.58, alpha:1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)

        view.addSubview(shoppingView)
        shoppingView.shoppingListTableView.backgroundColor? = .clear
        setupViews()
        UINavigationBar.appearance().tintColor = .black
        fetchShoppingCartItems()
        shoppingView.shoppingListTableView.dataSource    =   self
        shoppingView.shoppingListTableView.delegate      =   self
        shoppingView.shoppingListTableView.tableFooterView = UIView()
        shoppingView.payButton.addTarget(self, action: #selector(payButtonPressed), for: .touchUpInside)
        shoppingView.shoppingListTableView.reloadData()
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = shoppingView.payButton.center
        view.addSubview(activityView)
    }
    
    private func controlPayButton() {
        if ShoppingCartDataManager.cartTotal() > 0 {
            shoppingView.payButton.isEnabled = true
        } else {
            shoppingView.payButton.isEnabled = false
            let alerController = UIAlertController(title: "Your cart is empty." , message: "Please start scanning items in order to continue.", preferredStyle: .alert)

                        let ok = UIAlertAction(title: "OK", style: .default) { (action) in }
                        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in}
                        alerController.addAction(ok)
                        alerController.addAction(cancel)
                        present(alerController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.tabBarItem.badgeValue = "\(ShoppingCartDataManager.shoppingCartItemCounts.keys.count)"
        fetchShoppingCartItems()
        controlPayButton()
        shoppingView.shoppingListTableView.reloadData()
        shoppingCar()
        shoppingView.payButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0,delay: 0,usingSpringWithDamping: 0.2,initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in
                self?.shoppingView.payButton.transform = .identity
            }, completion: nil)
        updateViews()
    }
    
    private func shoppingCar() {
        if ShoppingCartDataManager.cartTotal() > 0 {
            shoppingView.payButton.isEnabled = true
        } else {
            shoppingView.payButton.isEnabled = false
        }
    }

    @objc func payButtonPressed() {
        payButtonPresse()
    }

    @objc private func fetchShoppingCartItems(){
        ShoppingCartDataManager.fetchShoppingCart()
        refresh.beginRefreshing()
    }
    
    private func setupViews() {
       setupShoppingView()
    }
    
    private func setupShoppingView() {
        shoppingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shoppingView.topAnchor.constraint(equalTo: view.topAnchor),
            shoppingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shoppingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shoppingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func createShoppingHistory(){
        guard let loggedInUser = authservice.getCurrentUser() else {
            showAlert(title: "Error", message: "No user currently logged in")
            return
        }
        
        for item in ShoppingCartDataManager.shoppingCartItemCounts.keys {

            DBService.createZipLineUserCheckoutHistory(zipLineUserID: loggedInUser.uid, zipLineUserCheckedOutItem: item) { (error) in
                if let error = error {
                    self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while creating \(String(describing: loggedInUser.displayName)) history")
                } else {
                }
            }
        }
    }
    @objc func payButtonPresse() {
        let addCardController = STPAddCardViewController()
        addCardController.delegate = self
        let navigationController = UINavigationController(rootViewController: addCardController)
        present(navigationController, animated: true, completion: nil)
        activityView.startAnimating()
    }
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingCartDataManager.shoppingCartItemCounts.keys.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = shoppingView.shoppingListTableView.dequeueReusableCell(withIdentifier: shoppingView.cell, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell()}
        
        let items = Array(ShoppingCartDataManager.shoppingCartItemCounts.keys)
        
        let itemInCart = items[indexPath.row]
            cell.shoppingLabelDetail.text = itemInCart.name
        
        cell.priceLabel.text = "$" + " \(itemInCart.price)"
        cell.shoppingListImage.kf.setImage(with: URL(string: itemInCart.image))
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        cell.addItemStepper.tag = indexPath.row
        stepperTags.append(cell.addItemStepper.tag)
        cell.addItemStepper.addTarget(self, action: #selector(changeStepperValue), for: .valueChanged)
        let value = Double(ShoppingCartDataManager.countOfItem(item: itemInCart))
        cell.addItemStepper.value = value
        cell.labelUpdate.text = "\(value)"
        refresh.endRefreshing()
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 1.0
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.5
        cell.backgroundColor = .clear
        return cell
    }
}

extension ShoppingListViewController{
    
    @objc private func changeStepperValue(_ stepper: UIStepper) {
        
        let items = Array(ShoppingCartDataManager.shoppingCartItemCounts.keys)

        let indexPath = IndexPath(row: stepper.tag, section: 0  )
        
        let itemInCart = items[indexPath.row]

        if ShoppingCartDataManager.countOfItem(item: itemInCart) < Int(stepper.value) {
            ShoppingCartDataManager.incrementCountOfItem(item: itemInCart, increment: 1)
        } else {
            ShoppingCartDataManager.decrementCountOfItem(item: itemInCart, decrement: 1)
        }
        
        guard let cell = shoppingView.shoppingListTableView.cellForRow(at: indexPath) as? ShoppingTableViewCell else { return }
        cell.labelUpdate.text = "\(stepper.value)"
       
        updateViews()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let items = Array(ShoppingCartDataManager.shoppingCartItemCounts.keys)
            
            let itemInCart = items[indexPath.row]
            
            ShoppingCartDataManager.deleteItemFromShoppingCart(item: itemInCart)
            self.shoppingView.payButton.isEnabled = false
            self.shoppingView.shoppingListTableView.deleteRows(at: [indexPath], with: .automatic)
            updateViews()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ShoppingListViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        dismiss(animated: true, completion: nil)
        showAlert(title: "\(authservice.getCurrentUser()?.displayName ?? "") Your transaction was successful. \n $\(ShoppingCartDataManager.cartTotal()) will be taken from your card", message: "Thank you for shopping with zipLine") { (alert) in
            self.barButtonItem.isEnabled = false
            
            var allItems = [Item]()

            for shoppedItem in ShoppingCartDataManager.shoppingCartItemCounts.keys {
                
                let checkedOutItem = Item.init(name: shoppedItem.name, barcode: shoppedItem.barcode, description: shoppedItem.description, ingredients: shoppedItem.ingredients, image: shoppedItem.image, price: shoppedItem.price, isCoupon: shoppedItem.isCoupon, coupon: shoppedItem.coupon, itemID: shoppedItem.itemID, date: Date(), tax: shoppedItem.tax, boughtDate: Date.getISOTimestamp())
                for _ in 0...ShoppingCartDataManager.countOfItem(item: checkedOutItem) {
                        allItems.append(checkedOutItem)
                    print(allItems.count)
                }
            }
        ReceiptDataManager.addToCheckoutItems(items: allItems)
        ShoppingCartDataManager.deleteAllItems()
        ShoppingCartDataManager.deleteAllItems()
         self.refresh.endRefreshing()
            self.navigationController!.pushViewController(ReceiptViewController(), animated: true)
        }
    }
}
