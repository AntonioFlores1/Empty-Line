//
//  ProductModel.swift
//  EmptyLine
//
//  Created by Donkemezuo Raymond Tariladou on 4/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct itemProduct:Codable {
    let code: String
    let offset: Int
    let size: String?
    let color: String?
    let width: String
    let length: String
    let brand: String
    let model: String
    let name: String
    let price: String
}
