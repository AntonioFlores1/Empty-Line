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
    static let allCheckedOutItemsCollectionKey = "allUserCheckedOutItems"
   static let shopperID = "shopperID"
   static let itemID = "itemID"
   static let name = "name"
   static let barcode = "barcode"
   static let description = "description"
   static let ingredients = "ingredients"
  static let image = "image"
   static let price = "price"
   static let isCoupon = "isCoupon"
   static let coupon = "coupon"
   static let date = "date"
}

extension DBService {
    
    static public func createZipLineUserCheckoutHistory(zipLineUserID: String, zipLineUserCheckedOutItem: Item, completionHandler: @escaping(Error?) -> Void){
        firestoreDB.collection(shoppedItemsCollectionKey.shoppingHistoryCollectionKey).document(zipLineUserID).collection(shoppedItemsCollectionKey.allCheckedOutItemsCollectionKey).addDocument(data: [shoppedItemsCollectionKey.shopperID : zipLineUserID, shoppedItemsCollectionKey.itemID : zipLineUserCheckedOutItem.itemID, shoppedItemsCollectionKey.barcode : zipLineUserCheckedOutItem.barcode, shoppedItemsCollectionKey.description : zipLineUserCheckedOutItem.description, shoppedItemsCollectionKey.ingredients : zipLineUserCheckedOutItem.ingredients, shoppedItemsCollectionKey.image : zipLineUserCheckedOutItem.image, shoppedItemsCollectionKey.isCoupon : zipLineUserCheckedOutItem.isCoupon, shoppedItemsCollectionKey.coupon : zipLineUserCheckedOutItem.coupon, shoppedItemsCollectionKey.name : zipLineUserCheckedOutItem.name]) { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
    static public func fetchzipLineUserCheckoutHistory(userID: String, completionHandler: @escaping (Error?, [Item]?, [String]?) -> Void){
//        DBService.firestoreDB.collection(shoppedItemsCollectionKey.shoppingHistoryCollectionKey).document(userID).collection(shoppedItemsCollectionKey.allCheckedOutItemsCollectionKey).getDocuments { (querySnapShot, error) in
//            if let error = error {
//                completionHandler(error, nil, nil)
//            } else {
//                if let querySnapShot = querySnapShot {
//                    var allZiplineUserCheckedOutItems = [Item]()
//                    for document in querySnapShot.documents {
//                        let checkedOutItem = Item.init(dict: document.data())
//                        allZiplineUserCheckedOutItems.append(checkedOutItem)
//                    }
//
//                    var checkedOutDates = [String]()
//                    for checkedOutItem in allZiplineUserCheckedOutItems {
//                        if !checkedOutDates.contains(checkedOutItem.createdAt) {
//                            checkedOutDates.append(checkedOutItem.createdAt)
//                        }
//                    }
//                    completionHandler(nil, allZiplineUserCheckedOutItems, checkedOutDates)
//                }
//            }
//        }
        
        DBService.firestoreDB.collection(shoppedItemsCollectionKey.shoppingHistoryCollectionKey).document(userID).collection(shoppedItemsCollectionKey.allCheckedOutItemsCollectionKey).addSnapshotListener(includeMetadataChanges: false) { (querySnapshot, error) in
            if let error = error {
                completionHandler(error, nil, nil)
            } else {
                if let querySnapShot = querySnapshot {
                    var allZiplineUserCheckedOutItems = [Item]()
                    for document in querySnapShot.documents {
                        let checkedOutItem = Item.init(dict: document.data())
                        allZiplineUserCheckedOutItems.append(checkedOutItem)
                    }

                    var checkedOutDates = [String]()
                    for checkedOutItem in allZiplineUserCheckedOutItems {
                        if !checkedOutDates.contains(checkedOutItem.createdAt) {
                            checkedOutDates.append(checkedOutItem.createdAt)
                        }
                    }
                    completionHandler(nil, allZiplineUserCheckedOutItems, checkedOutDates)
                }
            }
        }
        
    }
    

}



