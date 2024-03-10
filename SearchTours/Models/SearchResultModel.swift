//
//  SearchResultModel.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

struct SearchResultModel: Decodable {
    let results: [OfferModel]
    let stats: StatsModel
}
