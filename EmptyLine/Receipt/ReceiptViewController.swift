//
//  ReceiptViewController.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/26/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import MessageUI

class ReceiptViewController: UIViewController {
    
    let receiptView = ReceiptView()
    
    private var checkedOutItems = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.receiptView.itemsTableView.reloadData()
            }
        }
    }
    private var barButton = UIBarButtonItem()
    private var totalCost = 0.0
    private var totalTax = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(receiptView)
        receiptView.itemsTableView.delegate = self
        receiptView.itemsTableView.dataSource = self
        fetchCheckOutItemsForReceipt()
        receiptView.storeName.text = "SERVED BY:   Whole Foods Market"
        receiptView.itemsTableView.separatorStyle = .none
    }
    
    private func fetchCheckOutItemsForReceipt(){
        checkedOutItems = ReceiptDataManager.fetchCheckedOutItems()
        for item in checkedOutItems {
            totalCost += item.price
            totalTax += item.tax
        }
        
        receiptView.totalCostLabel.text = "Total: $\(Float(totalCost))"
        receiptView.taxLabel.text = "Tax: $\(Float(totalTax))"
        
    }
    
    private func setupBarButtonItem(){
        barButton = UIBarButtonItem.init(title: "Email Receipt", style: .plain, target: self, action: #selector(emailButtonClicked))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func emailButtonClicked(){
        //convertViewToPdf()
       let pdfFilePath = self.view.exportAPdfFromView()
        print(pdfFilePath)
    }
    
    private func convertViewToPdf(){
        let pageDimensions = receiptView.receiptScrollView.bounds
        let pageSize = pageDimensions.size
        let totalSize = receiptView.receiptScrollView.contentSize
        let numberOfPagesThatFitHorizontally = Int(ceil(totalSize.width/pageSize.width))
      let numberOfPagesThatFitVertically = Int(ceil(totalSize.height/pageSize.height))
        let outputData = NSMutableData()
        UIGraphicsBeginPDFContextToData(outputData, pageDimensions, nil)
        
        let savedContentOffset = receiptView.receiptScrollView.contentOffset
        let savedContentInset = receiptView.receiptScrollView.contentInset
        receiptView.receiptScrollView.contentInset = UIEdgeInsets.zero
        
        if let context = UIGraphicsGetCurrentContext() {
            for indexHorizontal in 0 ..< numberOfPagesThatFitHorizontally {
                for indexVertical in 0 ..< numberOfPagesThatFitVertically {
                    UIGraphicsBeginPDFPage()
                    let offsetHorizontal = CGFloat(indexHorizontal) * pageSize.width
                    let offsetVertical = CGFloat(indexVertical) * pageSize.height
                    
                    receiptView.receiptScrollView.contentOffset = CGPoint(x: offsetHorizontal, y: offsetVertical)
                   // CGContext.translateBy(context, CGSize(width: -offsetHorizontal, height: -offsetVertical))
                    
                    receiptView.receiptScrollView.layer.render(in: context)
                }
            }
        }
        
        UIGraphicsEndPDFContext()
        receiptView.receiptScrollView.contentInset = savedContentInset
        receiptView.receiptScrollView.contentOffset = savedContentOffset
        
        print("Convert to pdf")
    }
}

extension ReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkedOutItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = receiptView.itemsTableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath) as? ReceiptTableViewCell else { return UITableViewCell()}
        let checkOutItem = checkedOutItems[indexPath.row]
        cell.itemNameLabel.text = checkOutItem.name
        cell.itemPrice.text = "$" + "\(checkOutItem.price)"
        cell.selectionStyle = .none
        
        receiptView.dayLabel.text = "----------\(checkOutItem.boughtDate)----------"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

extension UIView {
    public func exportAPdfFromView() -> String {
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else {return "" }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return self.saveViewPdf(data: pdfData)
    }
    
    public func saveViewPdf(data: NSMutableData) -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("viewPdf.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
    
}
