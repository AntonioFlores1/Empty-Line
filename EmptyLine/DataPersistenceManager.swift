//
//  DataPersistenceManager.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
    
    // path to documents directory
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    // fireplath using filename to documents directory
    //"...Documents/PhotoJournalList.plist"
    static func filepathToDcoumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
}
}
