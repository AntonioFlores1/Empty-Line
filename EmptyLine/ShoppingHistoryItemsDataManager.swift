//
//  ItemDataManager.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ShoppingHistoryItemsDataManager {
private init() {}

private static var filename = "item.plist"

    static var total = 0.0
    static private var shoppedItems = [Item]() {
        didSet {
        }
    }
    
    static func saveItem(){
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(shoppedItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        }catch {
            print("property list encoding error: \(error)")
        }
    }

    static public func addToShoppingCart(item: Item, savedDate: String) {
        shoppedItems.removeAll()
        shoppedItems = fetchShoppingCartBYDay(CreatedDate: savedDate)
        shoppedItems.append(item)
        saveDate(createdAt: savedDate)
        shoppedItems.removeAll()
        shoppedItems = fetchShoppingCart()
        shoppedItems.append(item)
        saveItem()
        
    }
    static public func saveDate(createdAt: String) {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: createdAt)
        do {
            let data = try PropertyListEncoder().encode(shoppedItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
            
        } catch {
            print("property list encoding error: \(error)")
        }
    }
    
    static public func saveShoppingCart(shoppedDate: String, allItems: [Item]){
        
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: "\(shoppedDate).plist")
        do {
            let data = try PropertyListEncoder().encode(shoppedItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Property list encoding error")
        }
    }
    
    
    static public func deleteFromShoppingCart(index: Int) {
        shoppedItems.remove(at: index)
      saveItem()
    }
    static func totalAmount() -> Double {
        return total
    }
    
    static func fetchShoppingCart() -> [Item] {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path){
                do {
                    shoppedItems = try PropertyListDecoder().decode([Item].self, from: data)
                }catch {
                    print("Error: decoding error \(error.localizedDescription)")
                }
            } else {
                print("Error: File content is empty")
            }
        } else {
            print("Error: Filepath does not exist")
        }
        return shoppedItems
    }
    
    static func fetShoppingHistory(date: String) -> [Item] {
        
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: date).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path){
                do {
                    shoppedItems = try PropertyListDecoder().decode([Item].self, from: data)
                }catch {
                    print("Error: decoding error \(error.localizedDescription)")
                }
            } else {
                print("Error: File content is empty")
            }
        } else {
            print("Error: Filepath does not exist")
        }
        return shoppedItems
        
    }
    

    static func fetchShoppingCartBYDay(CreatedDate: String) -> [Item] {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: "\(CreatedDate).plist").path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path){
                do {
                    print(shoppedItems)
                    shoppedItems = try PropertyListDecoder().decode([Item].self, from: data)
                    print(shoppedItems)
                }catch {
                    print("Error: decoding error \(error.localizedDescription)")
                }
            } else {
                print("Error: File content \(path) is empty")
            }
        } else {
            print("Error: Filepath does not exist")
        }
        return shoppedItems
    }
    
    static func deleteAllItems(){
        shoppedItems.removeAll()
        saveItem()
    }
    
}
