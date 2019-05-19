//
//  Date+Extension.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 5/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension Date {
    
    static func getISOTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm a"
        let createdDate = formatter.string(from: Date())
        return createdDate
    }

}
