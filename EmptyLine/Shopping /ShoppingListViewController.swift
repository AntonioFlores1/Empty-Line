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
    
    var date = Date()
    var createdDate: String {  let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d, MMMM yyyy"
        let createdDate = formatter.string(from: date)
        return createdDate
        
    }
    

    private var list: ListenerRegistration?
    private var activityView: UIActivityIndicatorView!
    var productDetailView = ProductDetailsView()
    private var product:NumberOfItem?
    public var items: Item!
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
    
    private var shoppingCart = [Item](){
        didSet {
            DispatchQueue.main.async {
                self.shoppingView.shoppingListTableView.reloadData()
                self.shoppingView.titleLabel.resignFirstResponder()
        }
      }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.blue,UIColor.init(red: 41, green: 28, blue: 218, alpha: 1).cgColor,UIColor.purple.cgColor,]
        self.view.layer.addSublayer(gradient)
        view.addSubview(shoppingView)
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
        view.addSubview(activityView)
    }
 
    @objc func payButtonPressed() {
        print("pressed")
        payButtonPresse()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        fetchShoppingCartItems()
        shoppingView.shoppingListTableView.reloadData()
        shoppingView.payButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0,delay: 0,usingSpringWithDamping: 0.2,initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in
                self?.shoppingView.payButton.transform = .identity
            }, completion: nil)
        
    }

    @objc private func fetchShoppingCartItems(){
        shoppingCart = ShoppingCartDataManager.fetchShoppingCart()
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
        for item in shoppingCart {
            let shoppedItem = ItemSavedDate.init(createdDate: item.createdAt)
            savedDate.add(newDate: shoppedItem)
            ShoppingHistoryItemsDataManager.addToShoppingCart(item: item, savedDate: "\(shoppedItem.createdDate).plist")
            //shoppedItemsHistoryDataManager.addToCarts(items: shoppingCart)
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
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = shoppingView.shoppingListTableView.dequeueReusableCell(withIdentifier: shoppingView.cell, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell()}
        let itemInCart = shoppingCart[indexPath.row]
        cell.shoppingLabelDetail.text = itemInCart.name
        cell.priceLabel.text = "$" + " \(itemInCart.price)"
        cell.shoppingListImage.kf.setImage(with: URL(string: itemInCart.image))
        itemsPriceTotal = itemInCart.price // new
        itemsPriceTotal = ShoppingCartDataManager.total
        cell.addItemStepper.tag = indexPath.row
        stepperTags.append(cell.addItemStepper.tag)
        cell.addItemStepper.addTarget(self, action: #selector(changeStepperValue), for: .valueChanged)
        refresh.endRefreshing()
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 1.0
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.5

        return cell
    }
}

extension ShoppingListViewController{
   
    @objc private func changeStepperValue(_ stepper: UIStepper) {
        
        let item = shoppingCart[stepper.tag]
        if stepper.value == 1.0 || stepper.value == 0.0 {
            print(stepper.value)
            itemsPriceTotal = itemsPriceTotal + item.price
            ShoppingCartDataManager.addItemToCart(shoppingItem: item)
            //shoppingView.shoppingListTableView.reloadData()
            totalItems += 1
            stepper.value = 0
        } else if stepper.value == -1.0{
            if totalItems <= 1 {
               itemsPriceTotal = itemsPriceTotal - item.price
               totalItems = 1
            } else {
                itemsPriceTotal = itemsPriceTotal - item.price
                totalItems -= 1
                ShoppingCartDataManager.deleteItemFromShoppingCart(index: stepper.tag)
                stepper.value = 0
            }
        }
        let indexPath = IndexPath(row: stepper.tag, section: 0  )
        guard let cell = shoppingView.shoppingListTableView.cellForRow(at: indexPath) as? ShoppingTableViewCell else { return}
        cell.labelUpdate.text = totalItems.description
        print(item.price)
        print(itemsPriceTotal)
        
        switch cell {
        case cell:
            if indexPath.row == 0 {
                if stepper.value == 1.0{
                    totalItems += 1
                    stepper.value = 0
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 1{
                if stepper.value == 1.0{
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 2{
                if stepper.value == 1.0{
                    totalItems = +1
                } else {
                    totalItems -= 1
                }
            }        
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.shoppingCart.remove(at: indexPath.row)
            self.shoppingView.shoppingListTableView.deleteRows(at: [indexPath], with: .automatic)
            ShoppingCartDataManager.deleteItemFromShoppingCart(index: indexPath.row)
            self.itemsPriceTotal = ShoppingCartDataManager.totalAmount()
          
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
        showAlert(title: "\(authservice.getCurrentUser()?.displayName ?? "") Your transaction was successful. \n $\(Float(itemsPriceTotal)) will be taken from your card", message: "Thank you for shopping with zipLine") { (alert) in
            self.itemsPriceTotal = 0.0
            self.barButtonItem.isEnabled = false
            self.createShoppingHistory()
            ReceiptDataManager.addToCheckoutItems(items: self.shoppingCart)
           
            ShoppingCartDataManager.deleteAllItems()
            self.shoppingCart.removeAll()
            self.refresh.endRefreshing()
   
            self.navigationController!.pushViewController(ReceiptViewController(), animated: true)


        }
    }
    
}
