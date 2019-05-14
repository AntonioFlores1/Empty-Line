//
//  ReceiptDataManager.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/29/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ReceiptDataManager {
    private init() {}
    private static var filename = "receipt.plist"
    static private var checkedOutItems = [Item]()
    static func saveItems(){
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(checkedOutItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        }catch {
            print("Property list encoding")
        }
    }
    
    static public func addToCheckoutItems(items: Item){
        checkedOutItems.removeAll()
        checkedOutItems.append(items)
        saveItems()
    }
    
    static public func fetchCheckedOutItems() -> [Item] {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    checkedOutItems = try PropertyListDecoder().decode([Item].self, from: data)
                }catch {
                    
                    print("Error decoding \(error.localizedDescription)")
                }
            } else {
                print("content on file path is empty")
            }
        } else {
            print("File path does not exist")
        }
       return checkedOutItems
    }
}
