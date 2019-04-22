//
//  ItemCollection.swift
//  EmptyLine
//
//  Created by Alfredo Barragan on 4/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct ItemCollectionKeys {
    static let CollectionKey = "items"
    static let NameKey = "name"
    static let BarcodeKey = "barcode"
    static let DescriptionKey = "description"
    static let IngredientsKey = "ingredients"
    static let ImageKey = "image"
    static let PriceKey = "price"
    static let IsCouponKey = "iscoupon"
    static let CouponKey = "coupon"
    static let ItemIDKey = "itemID"
    static let createdAt = "createdAtKey"
    static let date = Date()
}


extension DBService {
    static public func createNDItem(item: Item, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(ItemCollectionKeys.CollectionKey)
            .document(item.itemID)
            .setData([ ItemCollectionKeys.NameKey        : item.name,
                       ItemCollectionKeys.BarcodeKey     : item.barcode,
                       ItemCollectionKeys.DescriptionKey : item.description,
                       ItemCollectionKeys.IngredientsKey : item.ingredients,
                       ItemCollectionKeys.ImageKey       : item.image,
                       ItemCollectionKeys.PriceKey       : item.price,
                       ItemCollectionKeys.IsCouponKey    : item.isCoupon,
                       ItemCollectionKeys.ItemIDKey      : item.itemID,
                       ItemCollectionKeys.createdAt : item.createdAt
                
            ]) { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    
   
}
