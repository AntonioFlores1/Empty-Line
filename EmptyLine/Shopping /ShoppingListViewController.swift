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
    var itemsPriceTotal: Double = 0.0 {
        didSet {
            shoppingView.titleLabel.text  = "Total Amount : \(Float(itemsPriceTotal))"
        }
    }
    

    var taxPriceTotal: Double = 0.0 {
        didSet {
            shoppingView.taxLabel.text = "Tax : \(Float(taxPriceTotal))"
        }
    }
    


    var date = Date()
    var createdDate: String {  let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d, MMMM yyyy"
        let createdDate = formatter.string(from: date)
        return createdDate
    }
    

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
    
// <<<<<<< prod
//     private var shoppingCart = [Item](){
//         didSet {
//             DispatchQueue.main.async {
//                 self.shoppingView.shoppingListTableView.reloadData()
//                 self.shoppingView.titleLabel.resignFirstResponder()
// =======
    private func updateViews () {
        DispatchQueue.main.async {
            self.shoppingView.shoppingListTableView.reloadData()
            self.shoppingView.titleLabel.text  = "Total Amount : $ \(ShoppingCartDataManager.cartTotal())"
            self.shoppingView.titleLabel.resignFirstResponder()
// >>>>>>> dev-antonio
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
        navigationItem.title = "Checkout List"
        fetchShoppingCartItems()
        shoppingView.shoppingListTableView.dataSource    =   self
        shoppingView.shoppingListTableView.delegate      =   self
        shoppingView.shoppingListTableView.tableFooterView = UIView()
        shoppingView.payButton.addTarget(self, action: #selector(payButtonPressed), for: .touchUpInside)
        shoppingView.shoppingListTableView.reloadData()
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = shoppingView.payButton.center
        //self.activityView.layer.addSublayer(gradient)
        // new
        view.addSubview(activityView)
    }
    
    private func controlPayButton() {
////<<<<<<< prod
//        if shoppingCart.isEmpty == true {
//            shoppingView.payButton.isEnabled = false
//            let alerController = UIAlertController(title: "Your cart is empty." , message: "Please start scanning items in order to continue.", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default) { (action) in }
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in}
//            alerController.addAction(ok)
//            alerController.addAction(cancel)
//            present(alerController, animated: true, completion: nil)
//        } else if shoppingCart.isEmpty != true {
//=======
        if ShoppingCartDataManager.cartTotal() > 0 {
//>>>>>>> dev-antonio
            shoppingView.payButton.isEnabled = true
        } else {
            shoppingView.payButton.isEnabled = false
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
// <<<<<<< prod
//             })
// =======
            }, completion: nil)
        updateViews()
//>>>>>>> dev-antonio
    }
    
    private func shoppingCar() {
        if ShoppingCartDataManager.cartTotal() > 0 {
            shoppingView.payButton.isEnabled = true
        } else {
            shoppingView.payButton.isEnabled = false
        }
    }

    @objc func payButtonPressed() {
        print("pressed")
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
                    print("Success")
                }
            }
        }
    }
    
    private func createReceipt(checkedOutItems: [Item]){
        
        for item in checkedOutItems {
            let checkedOutItem = Item.init(name: item.name, barcode: item.barcode, description: item.description, ingredients: item.ingredients, image: item.image, price: item.price, isCoupon: item.isCoupon, coupon: item.coupon, itemID: item.itemID, date: Date(), tax: item.tax, boughtDate: Date.getISOTimestamp())
            ReceiptDataManager.addToCheckoutItems(items: [checkedOutItem])
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
// <<<<<<< prod
//         itemsPriceTotal = itemInCart.price // new
//         itemsPriceTotal = ShoppingCartDataManager.total
//         taxPriceTotal = itemInCart.tax
//         taxPriceTotal = ShoppingCartDataManager.taxTotal
// =======
// >>>>>>> dev-antonio
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
// <<<<<<< prod
//     @objc private func changeStepperValue(_ stepper: UIStepper) {
//         let item = shoppingCart[stepper.tag]
//         if stepper.value == 1.0 || stepper.value == 0.0 {
//             print(stepper.value)
//             itemsPriceTotal = itemsPriceTotal + item.price
//             taxPriceTotal = taxPriceTotal + item.tax
//             ShoppingCartDataManager.addItemToCart(shoppingItem: item)
//             //shoppingView.shoppingListTableView.reloadData()
//             totalItems += 1
//             stepper.value = 0
//         } else if stepper.value == -1.0{
//             if totalItems <= 1 {
//                itemsPriceTotal = itemsPriceTotal - item.price
//                taxPriceTotal = taxPriceTotal - item.tax
//                totalItems = 1
//             } else {
//                 itemsPriceTotal = itemsPriceTotal - item.price
//                 taxPriceTotal = taxPriceTotal - item.tax
//                 totalItems -= 1
//                 ShoppingCartDataManager.deleteItemFromShoppingCart(index: stepper.tag)
//                 stepper.value = 0
//             }
//         }
// =======
    
    @objc private func changeStepperValue(_ stepper: UIStepper) {
        
        let items = Array(ShoppingCartDataManager.shoppingCartItemCounts.keys)
        
//>>>>>>> dev-antonio
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
// <<<<<<< prod
//             print("Deleted")
//             self.shoppingCart.remove(at: indexPath.row)
//             if shoppingCart.isEmpty == true {
//                 let alerController = UIAlertController(title: "Your cart is empty." , message: "Please start scanning items in order to continue.", preferredStyle: .alert)
//                 let ok = UIAlertAction(title: "OK", style: .default) { (action) in }
//                 let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in}
//                 alerController.addAction(ok)
//                 alerController.addAction(cancel)
//                 present(alerController, animated: true, completion: nil)
//             }
//             self.shoppingView.payButton.isEnabled = false
//             self.shoppingView.shoppingListTableView.deleteRows(at: [indexPath], with: .automatic)
//             ShoppingCartDataManager.deleteItemFromShoppingCart(index: indexPath.row)
//             self.itemsPriceTotal = ShoppingCartDataManager.totalAmount()
// =======
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
//            self.itemsPriceTotal = 0.0
            //self.shoppingCart.removeAll()
           // self.refresh.endRefreshing()
            self.barButtonItem.isEnabled = false
            self.createShoppingHistory()
// <<<<<<< prod
//             ReceiptDataManager.addToCheckoutItems(items: self.shoppingCart)
//             ShoppingCartDataManager.deleteAllItems()
//             self.shoppingCart.removeAll()
//             self.refresh.endRefreshing()
// =======
            
            var allItems = [Item]()
          
            for item in ShoppingCartDataManager.shoppingCartItemCounts.keys {
                for _ in 0...ShoppingCartDataManager.countOfItem(item: item) {
                        allItems.append(item)
                    
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
