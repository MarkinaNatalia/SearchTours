//
//  TourModel.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

struct TourModel: Decodable {
    let id: String
    let title: String?
    let price: PriceModel
    let adults: Int
    let kids: Int
    let startDate: String
    let duration: Int
    let hotelDuration: Int
    let tourDuration: Int
    let originalName: String?
}
