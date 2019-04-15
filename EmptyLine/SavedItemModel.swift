//
//  SavedItemModel.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct SavedItem: Codable {
    let itemName: String
    let itemBarcode: String
    let itemDescription: String
    let itemIngredients: String?
    let itemImage: String
    let itemPrice: Double
    let isCoupon: Bool
    let coupon: Double
}
