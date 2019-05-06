//
//  ShoppedHistoryCollection.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 5/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct shoppedItemsCollectionKey {
    static let shoppingHistoryCollectionKey = "CheckoutItems"
   static let shopperID = "shopperID"
   static let itemID = "itemID"
   static let name = "itemName"
   static let barcode = "itemBarcode"
   static let description = "itemDescription"
   static let ingredients = "itemIngredients"
  static let image = "itemImage"
   static let price = "itemPrice"
   static let isCoupon = "itemHasCoupon"
   static let coupon = "couponAmount"
   static let date = "createdDate"
}

extension DBService {
    static public func createCheckoutHistory(userID: String,shopper:Item, completion: @escaping(Error?) -> Void){
        firestoreDB.collection(shoppedItemsCollectionKey.shoppingHistoryCollectionKey).document(userID).setData([shoppedItemsCollectionKey.shopperID : userID, shoppedItemsCollectionKey.itemID : shopper.itemID, shoppedItemsCollectionKey.name : shopper.name, shoppedItemsCollectionKey.barcode : shopper.barcode, shoppedItemsCollectionKey.description : shopper.description, shoppedItemsCollectionKey.ingredients : shopper.ingredients, shoppedItemsCollectionKey.image : shopper.image, shoppedItemsCollectionKey.price : shopper.price, shoppedItemsCollectionKey.isCoupon : shopper.isCoupon, shoppedItemsCollectionKey.coupon : shopper.coupon, shoppedItemsCollectionKey.date : shopper.date,
        ]) {(error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }

    static public func fetchShoppedHistory(completion: @escaping(Error?, [Item]?, [String]? ) -> Void){
        DBService.firestoreDB.collection(shoppedItemsCollectionKey.shoppingHistoryCollectionKey).getDocuments { (snapShot, error) in
            if let error = error {
                completion(error, nil, nil)
            }
            if let snapshot = snapShot {
                var allCheckOutItems = [Item]()
                for document in snapshot.documents {
                    let checkOutItem = Item.init(dict: document.data())
                    allCheckOutItems.append(checkOutItem)
                }
                
                var dates = [String]()
                for checkoutdate in allCheckOutItems {
                    if !dates.contains(checkoutdate.createdAt){
                        dates.append(checkoutdate.createdAt)
                    }
                }
                completion(nil, allCheckOutItems, dates)
            }
        }
        
    }

}



