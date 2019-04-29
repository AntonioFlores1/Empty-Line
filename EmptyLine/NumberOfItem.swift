//
//  NumberOfItem.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/29/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct NumberOfItem: Codable {
    let numItem: Int
    let barcode: String
    let name: String
    let itemID: String
    
    init(numItem: Int,barcode: String, name: String, itemID: String ) {
        self.numItem = numItem
        self.barcode = barcode
        self.name = name
        self.itemID = itemID
    }
    init(dict: [String: Any]) {
        self.barcode = dict[ItemCollectionK.Barcode] as? String ?? ""
        self.name = dict[ItemCollectionK.Name] as? String ?? ""
        self.itemID = dict[ItemCollectionK.ItemID] as? String ?? ""
        self.numItem =  dict[ItemCollectionK.NumItem] as? Int ?? 0
    }
}
