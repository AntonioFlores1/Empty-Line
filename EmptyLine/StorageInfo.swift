//
//  StorageInfo.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StorageInfo {
    let qrcode: String
    let storageID: String
        let street: String
        let city: String
        let zipCode: String
        let state: String
            let name: String
            let isCupon: Bool
            let cuponAmaunt: String
            let itemBarcode: String
    
    init(qrcode: String,storageID: String, street:String, city: String,zipCode: String, state: String, name: String , isCupon: Bool, cuponAmaunt: String, itemBarcode: String) {
        self.qrcode = qrcode
        self.storageID = storageID
        self.street = street
        self.city = city
        self.zipCode = zipCode
        self.state = state
        self.name = name
        self.isCupon = isCupon
        self.cuponAmaunt = cuponAmaunt
        self.itemBarcode = itemBarcode
    }
    init(dict: [String: Any]) {
        self.qrcode = dict[StorageCollectionKeys.QRCodeKey] as? String ?? ""
        self.city = dict[StorageCollectionKeys.CityKey] as? String ?? ""
        self.cuponAmaunt = dict[StorageCollectionKeys.CuponAmountKey] as? String ?? ""
        self.isCupon = (dict[StorageCollectionKeys.IsCuponKey] as? Bool)!
        self.itemBarcode = dict[StorageCollectionKeys.ItemBarCodeKey] as? String ?? ""
        self.name = dict[StorageCollectionKeys.NameKey] as? String ?? ""
        self.state = dict[StorageCollectionKeys.StateKey] as? String ?? ""
        self.storageID = dict[StorageCollectionKeys.StorageIDKey] as? String ?? ""
        self.street = dict[StorageCollectionKeys.StateKey] as? String ?? ""
        self.zipCode = dict[StorageCollectionKeys.ZipCodeKey] as? String ?? ""
    }
}
