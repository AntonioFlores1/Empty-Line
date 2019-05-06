//
//  ShoppedItem.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 5/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct shoppedItem {
    let shopperID: String
    let itemID: String
    let name: String
    let barcode: String
    let description: String
    let ingredients: String
    let image: String
    let price: Double
    let isCoupon: Bool
    let coupon: Double
    let date:String
    
    init(shopperID: String, itemID: String, name: String, barcode: String, description: String, ingredients: String, image: String, price: Double, isCoupon: Bool, coupon: Double, date: String){

    self.shopperID = shopperID
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
        self.shopperID = dict[shoppedItemsCollectionKey.shopperID] as? String ?? ""
        self.itemID = dict[shoppedItemsCollectionKey.itemID] as? String ?? ""
        self.name = dict[shoppedItemsCollectionKey.name] as? String ?? ""
        self.barcode = dict[shoppedItemsCollectionKey.barcode] as? String ?? ""
        self.description =  dict[shoppedItemsCollectionKey.description] as? String ?? ""
        self.ingredients = dict[shoppedItemsCollectionKey.ingredients] as? String ?? ""
        self.image = dict[shoppedItemsCollectionKey.image] as? String ?? ""
        self.price = dict[shoppedItemsCollectionKey.price] as? Double ?? 0.0
        self.isCoupon = dict[shoppedItemsCollectionKey.isCoupon] as? Bool ?? false
        self.coupon = dict[shoppedItemsCollectionKey.coupon] as? Double ?? 0.0
        self.date = dict[shoppedItemsCollectionKey.date] as? String ?? ""
    }


}
