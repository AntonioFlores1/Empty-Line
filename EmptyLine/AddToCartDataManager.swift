//
//  AddToCartDataManager.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ShoppingCartDataManager {
//<<<<<<< prod
    private init() {}
    static weak var delegate: UptadeNumberOfItemsDelegate?
//=======
//>>>>>>> dev-antonio
    private static var filename = "shoppingCart.plist"
    
    static var shoppingCartItemCounts = [Item:Int]()
    
// <<<<<<< prod
//     static var total = 0.0
//     static var taxTotal = 0.0
//     static private var shoppingCartItems = [Item]() {
//         didSet {
//             total = 0.0
//             for item in self.shoppingCartItems {
//                self.total += item.price
//             }
//             delegate?.updateNumOfItem(items: shoppingCartItems)
//         }
//     }
//     static private var taxCartItems = [Item]() {
//         didSet {
//             taxTotal = 0.0
//             for item in self.shoppingCartItems {
//                 self.taxTotal += item.tax
//             }
    
// =======
    static func cartTotal() -> Double {
        var total: Double = 0
        for item in shoppingCartItemCounts.keys {
            total = total + itemTotal(item: item)
        }
        return total
    }
    
    static func itemTotal(item: Item) -> Double {
        if let count = shoppingCartItemCounts[item] {
            return Double(count) * item.price
//>>>>>>> dev-antonio
        }
        return 0
    }
// <<<<<<< prod
//     static func totalAmount() -> Double {
//         return total
// =======
    
    static func countOfItem(item: Item) -> Int {
        if let count = shoppingCartItemCounts[item] {
            return count
        } else {
            return 0
        }
    }
    
    static func incrementCountOfItem(item: Item, increment: Int) {
        if let count = shoppingCartItemCounts[item] {
            shoppingCartItemCounts[item] = count + increment
        }
    
//>>>>>>> dev-antonio
    }
    
    static func decrementCountOfItem(item: Item, decrement: Int) {
        if let count = shoppingCartItemCounts[item] {
            shoppingCartItemCounts[item] = count - decrement
        }
    }

    static func saveShoppingItems(){
        
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(shoppingCartItemCounts)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        }catch {
            print("property list encoding error: \(error)")
        }
        
    }

    static func addItemToCart(shoppingItem: Item) {
        let keys = Array(shoppingCartItemCounts.keys)
        let thing = keys.first { (item) -> Bool in
            item.name == shoppingItem.name
        }
        
        if let item = thing {
            let count = shoppingCartItemCounts[item]!
            shoppingCartItemCounts[item] = count + 1
        } else {
            shoppingCartItemCounts[shoppingItem] = 1
        }
        saveShoppingItems()
    }
    
    static func fetchShoppingCart() {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    shoppingCartItemCounts = try PropertyListDecoder().decode([Item:Int].self, from: data)
                }catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("No data exist on this \(path) file path")
            }
        } else {
            print("File \(filename) does not exist")
        }
    }
    
    static func deleteItemFromShoppingCart(item: Item) {
        shoppingCartItemCounts[item] = nil
        saveShoppingItems()
    }

    static func deleteAllItems(){
        shoppingCartItemCounts.removeAll()
        saveShoppingItems()
    }
}
