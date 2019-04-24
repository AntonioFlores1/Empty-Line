//
//  AddToCartDataManager.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class ShoppingCartDataManager {
    private init() {}
    
    private static var filename = "shoppingCart.plist"
    
    
    static var total = 0.0
    static private var shoppingCartItems = [Item]() {
        didSet {
            total = 0.0
            for item in self.shoppingCartItems {
                self.total += item.price
            }
        }
    }
    
    static func saveShoppingItems(){
        
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(shoppingCartItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        }catch {
            print("property list encoding error: \(error)")
        }
        
    }
    
    static func addItemToCart(shoppingItem: Item) {
        shoppingCartItems.append(shoppingItem)
        saveShoppingItems()
    }
    
    static func fetchShoppingCart() -> [Item] {
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    shoppingCartItems = try PropertyListDecoder().decode([Item].self, from: data)
                }catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("No data exist on this \(path) file path")
            }
        } else {
            print("File \(filename) does not exist")
        }
        return shoppingCartItems
    }
    
    static func deleteItemFromShoppingCart(index: Int) {
        shoppingCartItems.remove(at: index)
        saveShoppingItems()
    }
}
