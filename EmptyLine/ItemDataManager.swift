//
//  ItemDataManager.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ItemsDataManager {
private init() {}

private static var filename = "item.plist"
    static private var shoppingCartItems = [Item]() {
        didSet {
            total = 0.0
            for item in self.shoppingCartItems {
                self.total += item.price
            }
        }
    }
static var total = 0.0

    
    static func saveItem(){
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(shoppingCartItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        }catch {
            print("property list encoding error: \(error)")
        }
    }

    static public func addToShoppingCart(item: Item, savedDate: String) {
        shoppingCartItems.removeAll()
        shoppingCartItems = fetchShoppingCartBYDay(CreatedDate: savedDate)
        shoppingCartItems.append(item)
        saveDate(createdAt: savedDate)
        saveItem()
        
    }
    static public func saveDate(createdAt: String) {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: createdAt)
        do {
            let data = try PropertyListEncoder().encode(shoppingCartItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }
    
    
    static public func deleteFromShoppingCart(index: Int) {
        shoppingCartItems.remove(at: index)
        saveItem()
    }
    static func totalAmount() -> Double {
        return self.total
    }
    static func fetchShoppingCart() -> [Item] {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path){
                do {
                    shoppingCartItems = try PropertyListDecoder().decode([Item].self, from: data)
                }catch {
                    print("Error: decoding error \(error.localizedDescription)")
                }
            } else {
                print("Error: File content is empty")
            }
        } else {
            print("Error: Filepath does not exist")
        }
        return shoppingCartItems
    }
    

    static func fetchShoppingCartBYDay(CreatedDate: String) -> [Item] {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: "\(CreatedDate).plist").path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path){
                do {
                    shoppingCartItems = try PropertyListDecoder().decode([Item].self, from: data)
                }catch {
                    print("Error: decoding error \(error.localizedDescription)")
                }
            } else {
                print("Error: File content is empty")
            }
        } else {
            print("Error: Filepath does not exist")
        }
        return shoppingCartItems
    }
    
}
