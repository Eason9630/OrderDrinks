//
//  OrdersRecords.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/23.
//

import Foundation

struct OrdersRecords: Codable {
    var records: [OrderRecords]
}
struct OrderRecords: Codable {
    var id:String?
    var fields:OrderItem
}
struct OrderItem: Codable {
    var orderName: String
    var drinksName: String
    var suger: String
    var ice: String
    var count: String
    var topping:String
    var price:String
}
enum Size:String ,CaseIterable {
    case medium = "中杯"
    case large = "大杯"
}

enum Suger:String,CaseIterable{
    case normalSugar = "正常"
    case seventySugar = "七分糖"
    case halfSugar = "半糖"
    case thirtySugar = "三分糖"
    case zeroSugar = "無糖"
}
enum Ice: String, CaseIterable {
    case fullIce = "正常"
    case seventyIce = "少冰"
    case thirtyIce = "微冰"
    case zeroIce = "去冰"
    case hotTemp = "熱飲"
}

enum Topping: String, CaseIterable {
    case whiteBubble = "白玉珍珠"   // White Tapioca
    case blackBubble = "墨玉珍珠"   // Tapioca
}
