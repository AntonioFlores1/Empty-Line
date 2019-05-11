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
    
    static var stepperTagReference = 1
    static var steppervalue = 1
    
    
    static var shoppingCartItems = [Item]() {
        didSet {
//            var shoppingItems: [Item:Int] = [:]
//            var newStuff:[Item] = []
//
//            for item in self.shoppingCartItems{
//                if let update = shoppingItems[item] {
//                          shoppingItems[item] = update + 1
//                    print("meeeeee \(update)")
//                } else {
//                    newStuff.append(item)
//                    shoppingItems[item] = 1
//                }
//            }
//            newStuff.sort(by: >)
//
//            for number in newStuff {
//                print("\(number) \(shoppingItems[number]!) Antoniooooooooooo")
//            }
            //when i add something to my shopping cart, if the item doesn't exist in my shopping cart, add item and make its frequency 1
            //if item exists in my shopping cart, increase frequency
            //stepper will increase or decrease the frequency
            //**make sure when the frequency is zero or when you delete an item, that you don't show that in the cart in the UI
            total = 0.0
//            for item in self.shoppingCartItems {
//                self.total += item.price
//            }
        }
    }
    
    static func stepperFrequency(indexOfStepper:Int,stepperValue:Int) {
        var shoppingItems: [Item:Int] = [:]
        var newStuff:[Item] = []
        
        let myItemInArray = shoppingCartItems[indexOfStepper]
        for item in shoppingCartItems{
            if myItemInArray == item {
                print("Fuck thissssssssssss  \(myItemInArray), \(item)")
                shoppingItems[item] = stepperValue
                if let update = shoppingItems[item] {
                    print("i made it innnnnn \(stepperValue)")
                } else {
                    newStuff.append(item)
                    shoppingItems[item] = 1
                }
            }
            
        }
        newStuff.sort(by: >)
        for number in newStuff {
            print("\(number) \(shoppingItems[number]!) Antoniooooooooooo")
        }
    }
    
   
    static func totalAmount() -> Double {
        return total
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
    static func deleteAllItems(){
        shoppingCartItems.removeAll()
        saveShoppingItems()
    }
}
