//
//  ShoppedItemsHistoryDatamanager.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 5/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class shoppedItemsHistoryDataManager {
    private init() {}
    
 private static var filename = "allItems.plist"
    
    static public func saveItem(){
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(allCheckedOutItems)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Error: \(error.localizedDescription) encountered while encoding data in file path")
        }
    }
    
    
    static private var allCheckedOutItems = [Item](){
        didSet {
            
        }
    }
    
    static public func addToCarts(items: [Item]) {
        allCheckedOutItems.removeAll()
        allCheckedOutItems = items
        saveItem()
    }
    
    static public func fetchHistory()-> [Item]{
        let path = DataPersistenceManager.filepathToDcoumentsDirectory(filename:filename).path
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    allCheckedOutItems = try PropertyListDecoder().decode([Item].self, from: data)
                } catch {
                    print("Error: \(error.localizedDescription) while decoding data")
                }
            } else {
                print("There is no data on this \(filename) filepath")
            }
        } else {
            print("File path \(filename) does not exist")
        }
        return allCheckedOutItems
    }
    
    
}
