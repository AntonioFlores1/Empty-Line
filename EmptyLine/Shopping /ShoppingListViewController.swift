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

    var productDetailView = ProductDetailsView()
    public var items: Item!
    private var shoppingView = ShoppingView()
    private var listener: ListenerRegistration!
    private let authservice = AppDelegate.authservice
    private var barButtonItem = UIBarButtonItem()
    var shoppingImage = UIImage()
    var stepperTags = [Int]()
    
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
        shoppingListTableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        shoppingListTableView.delegate      =   self
        shoppingListTableView.dataSource    =   self
        fetchShoppingCartItems()
        self.itemsPriceTotal = ShoppingHistoryItemsDataManager.totalAmount()
        shoppingListTableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: "cell")
        barButtonItem = UIBarButtonItem(title: "Pay", style: .done, target: self, action: #selector(barButtonPressed))
        navigationItem.rightBarButtonItem = barButtonItem
        self.view.addSubview(self.shoppingListTableView)
        shoppingListTableView.tableFooterView = shoppingView
        shoppingListTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        shoppingListTableView.reloadData()
    }
    @objc private func fetchShoppingCartItems(){
        shoppingCart = ShoppingCartDataManager.fetchShoppingCart()
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
        itemsPriceTotal = itemInCart.price // new
        itemsPriceTotal = ShoppingCartDataManager.total
        cell.addItemStepper.tag = indexPath.row
        stepperTags.append(cell.addItemStepper.tag)
        cell.addItemStepper.addTarget(self, action: #selector(changeStepperValue), for: .valueChanged)
//        self.shoppingListTableView.reloadData()
        refresh.endRefreshing()
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 1.0
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.5
        return cell
    }
    
    @objc private func changeStepperValue(_ stepper: UIStepper) {
        let item = shoppingCart[stepper.tag]
        
        if stepper.value == 1.0 || stepper.value == 0.0 {
            print(stepper.value)
            itemsPriceTotal = itemsPriceTotal + item.price
            totalItems += 1
            stepper.value = 0
        } else if stepper.value == -1.0 {
            if totalItems <= 1{
               totalItems = 1
            } else {
                itemsPriceTotal = itemsPriceTotal - item.price
                totalItems -= 1
                stepper.value = 0
            }
        }
        let indexPath = IndexPath(row: stepper.tag, section: 0  )
        guard let cell = shoppingListTableView.cellForRow(at: indexPath) as? ShoppingTableViewCell else { return}
        cell.labelUpdate.text = totalItems.description
        print(item.price)
        print(itemsPriceTotal)
        
        switch cell {
        case cell:
            if indexPath.row == 0 {
                if stepper.value == 1.0 {
                    print("rrr")
                    totalItems += 1
                } else if stepper.value == -1.0{
                    if totalItems <= 1{
                        totalItems -= 1
                    } else {
                        totalItems -= 1
                    }
                }
            }
        case cell:
            if indexPath.row == 1{
                 print("jgsgk")
                if stepper.value == 1.0 {
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 2 || stepper.value == 0.0{
                print("jsgfs;jg;sfjgs")
                if stepper.value == 1.0 {
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 3 {
                if stepper.value == 1.0 {
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 4 {
                if stepper.value == 1.0 {
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 5 {
                if stepper.value == 1.0 {
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 6 {
                if stepper.value == 1.0 {
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 7 {
                if stepper.value == 1.0 {
                    totalItems += 1
                } else {
                    totalItems -= 1
                }
            }
        case cell:
            if indexPath.row == 8 {
                if stepper.value == 1.0 {
                    totalItems += 1
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
            self.shoppingListTableView.deleteRows(at: [indexPath], with: .automatic)
            ShoppingCartDataManager.deleteItemFromShoppingCart(index: indexPath.row)
            self.itemsPriceTotal = ShoppingCartDataManager.total
          
        }
    }

    private func fetchProduct(shoppingItems: String) {
        DBService.getProducts(productBarcode: shoppingItems) { (error, items) in
            if let error = error {
                self.showAlert(title: "Error fetching product information", message: error.localizedDescription)
            } else if let items = items {
                self.items = items
                self.productDetailView.productName.text = items.name
                self.productDetailView.productDetails.text = items.description
                self.productDetailView.productPrice.text = "$" + String(items.price)
                self.productDetailView.productNutritionDetails.text = items.ingredients
                self.productDetailView.productImage.kf.setImage(with: URL(string: items.image))
            }
        }
    }
    
    func fecthShoppingHistory() {
        if let purches = items {
            self.productDetailView.productName.text = items.name
            self.productDetailView.productDetails.text = items.description
            self.productDetailView.productPrice.text = "$" + String(items.price)
            self.productDetailView.productNutritionDetails.text = items.ingredients
            self.productDetailView.productImage.kf.setImage(with: URL(string: items.image))
        }
    }
//            self.navigationController?.pushViewController(HistoryDetailViewController(), animated: true)
//    func fecthShoppingHistory() {
//        if let purches = items {
//           // ItemsDataManager.addToShoppingCart(item: purches)
//            self.productDetailView.productName.text = items.name
//            self.productDetailView.productDetails.text = items.description
//            self.productDetailView.productPrice.text = "$" + String(items.price)
//            self.productDetailView.productNutritionDetails.text = items.ingredients
//            self.productDetailView.productImage.kf.setImage(with: URL(string: items.image))
////            self.navigationController?.pushViewController(HistoryDetailViewController(), animated: true)
//        }
//    }
    
    private func createShoppingHistory(){
        for item in shoppingCart {
            let shoppedItem = ItemSavedDate.init(createdDate: item.createdAt)
            savedDate.add(newDate: shoppedItem)
            ShoppingHistoryItemsDataManager.addToShoppingCart(item: item, savedDate: "\(shoppedItem.createdDate).plist")
            ShoppingHistoryItemsDataManager.saveItem()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension ShoppingListViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        dismiss(animated: true, completion: nil)
        showAlert(title: "\(authservice.getCurrentUser()?.displayName ?? "") Your transaction was success. \n $\(Float(itemsPriceTotal)) will be taken from your card", message: "Thank you for shopping with zipLine.")
        itemsPriceTotal = 0.0
        shoppingCart.removeAll()
        ShoppingCartDataManager.deleteItemFromShoppingCart(index: shoppingCart.count)
        shoppingListTableView.reloadData()
        barButtonItem.isEnabled = false
        createShoppingHistory()
        refresh.endRefreshing()
    }
}
