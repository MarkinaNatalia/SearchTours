//
//  PriceModel.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

struct PriceModel: Decodable {
    let total: Int
    let partner: Int
    let subtotal: Int
    let original: Int
    let oilTax: Int
    let insuranceTax: Int
    let markup: Int
    let lowFee: Bool
}
