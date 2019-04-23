//
//  Item.swift
//  EmptyLine
//
//  Created by Alfredo Barragan on 4/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Item: Codable {
    let itemID: String
    let name: String
    let barcode: String
    let description: String
    let ingredients: String
    let image: String
    let price: Double
    let isCoupon: Bool
    let coupon: Double
    let date:Date
    
    var createdAt: String {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMMM EEEE"
        let createdDate = formatter.string(from: date)
        
        return createdDate
    }
    
    init(name: String, barcode: String, description: String, ingredients: String, image: String, price: Double, isCoupon: Bool , coupon: Double, itemID: String, date: Date) {
        self.itemID = itemID
        self.name = name
        self.barcode = barcode
        self.description = description
        self.ingredients = ingredients
        self.image = image
        self.price = price
        self.isCoupon = isCoupon
        self.coupon = coupon
        self.date = date
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
        self.date = dict[ItemCollectionKeys.createdAt] as? Date ?? Date()
    }
    
}
