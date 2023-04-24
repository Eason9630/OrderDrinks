//
//  Menu.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/23.
//

import Foundation

struct MenuDate: Codable {
    let records: [Records]
}

struct Records: Codable {
    let id: String
    let fields: Fields
    
}

struct Fields: Codable {
    let number: String
    let descript: String
    let name: String
    let priceL: String?
    let priceM: String?
    let image:[imageUrl]
    let sort:String
}

struct imageUrl: Codable {
    let url: URL
}
