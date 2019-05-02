//
//  ItemCollectionKeys.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/29/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ItemCollectionK {
    static let CollectionKey = "item"
    static let NumItem = "numItem"
    static let Barcode = "barcode"
    static let Name = "name"
    static let ItemID = "itemID"
}

extension DBService {
    static public func itemCollection(numberOfItem: NumberOfItem, completion: @escaping(Error?) -> Void) {
        firestoreDB.collection(ItemCollectionK.CollectionKey)
                   .document(numberOfItem.itemID)
            .setData( [ItemCollectionK.Barcode: numberOfItem.barcode,
                       ItemCollectionK.ItemID: numberOfItem.itemID,
                       ItemCollectionK.Name: numberOfItem.name,
                       ItemCollectionK.NumItem: numberOfItem.numItem])
            { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
}
