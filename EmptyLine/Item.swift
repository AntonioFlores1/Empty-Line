//
//  Item.swift
//  EmptyLine
//
//  Created by Alfredo Barragan on 4/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
// <<<<<<< prod

// struct Item: Codable {
// =======
struct Item: Codable,Hashable,Comparable {
    static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.self == rhs.self
    }
    
//>>>>>>> dev-antonio
    let itemID: String
    let name: String
    let barcode: String
    let description: String
    let ingredients: String
    let image: String
    let price: Double
    let isCoupon: Bool
    let coupon: Double
    let boughtDate: String
    let tax: Double

 
    
    init(name: String, barcode: String, description: String, ingredients: String, image: String, price: Double, isCoupon: Bool , coupon: Double, itemID: String, date: Date, tax: Double, boughtDate: String) {
      
        self.itemID = itemID
        self.name = name
        self.barcode = barcode
        self.description = description
        self.ingredients = ingredients
        self.image = image
        self.price = price
        self.isCoupon = isCoupon
        self.coupon = coupon
        self.tax = tax
        self.boughtDate = boughtDate
    }
    
    init(dict: [String: Any]) {
        self.name = dict[ItemCollectionKeys.NameKey] as? String ?? ""
        self.barcode = dict[ItemCollectionKeys.BarcodeKey] as? String ?? ""
        self.description = dict[ItemCollectionKeys.DescriptionKey] as? String ?? ""
        self.ingredients = dict[ItemCollectionKeys.IngredientsKey] as? String ?? ""
        self.image = dict[ItemCollectionKeys.ImageKey] as? String ?? ""
        self.price = dict[ItemCollectionKeys.PriceKey] as? Double ?? 0.0
        self.isCoupon = dict[ItemCollectionKeys.IsCouponKey] as? Bool ?? false
        self.coupon = dict[ItemCollectionKeys.CouponKey] as? Double ?? 0.0
        self.itemID = dict[ItemCollectionKeys.ItemIDKey] as? String ?? ""
        self.tax = dict[ItemCollectionKeys.taxKey] as? Double ?? 0.0
        self.boughtDate = dict[ItemCollectionKeys.boughtDate] as? String ?? "no purchase date"
    }

    
}
