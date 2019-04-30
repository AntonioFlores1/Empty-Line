//
//  Storage.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct StorageCollectionKeys {
    static let CollectionKey = "storages"
    static let StorageIDKey = "storageID"
    static let CityKey = "city"
    static let ZipCodeKey = "zipCode"
    static let StateKey = "state"
    static let NameKey = "name"
    static let IsCuponKey = "isCupon"
    static let CuponAmountKey = "cuponAmount"
    static let ItemBarCodeKey = "itemBarcode"
    static let QRCodeKey = "qrcode"
}

extension DBService {
    static public func createStorage(storage: StorageInfo, completion: @escaping(Error?) -> Void) {
        firestoreDB.collection(StorageCollectionKeys.CollectionKey)
        .document(storage.storageID)
            .setData([ StorageCollectionKeys.CityKey : storage.city,
                       StorageCollectionKeys.CuponAmountKey: storage.cuponAmaunt,
                       StorageCollectionKeys.IsCuponKey: storage.isCupon,
                       StorageCollectionKeys.ItemBarCodeKey: storage.itemBarcode,
                       StorageCollectionKeys.NameKey: storage.name,
                       StorageCollectionKeys.StateKey: storage.state,
                       StorageCollectionKeys.StorageIDKey: storage.storageID,
                       StorageCollectionKeys.ZipCodeKey: storage.zipCode,
                       StorageCollectionKeys.QRCodeKey: storage.qrcode,
            ]) { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
            }
        }
    }
}
