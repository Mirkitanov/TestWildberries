//
//  JsonModelStorage.swift
//  WildberriesTest
//
//  Created by Админ on 07.06.2022.
//

import Foundation

struct JsonDefaultModel: Codable {
    let meta: Meta
    let data: [FlightDefaultModel]
}

struct FlightDefaultModel: Codable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
}

struct Meta: Codable {
}

struct Flight: Codable {
    var startCity: String
    var startCityCode: String
    var endCity: String
    var endCityCode: String
    var startDate: String
    var endDate: String
    var price: Int
    var searchToken: String
    var like: Bool
}

struct FlightSection {
    var flightes: [Flight]
}

struct FlightStorage {
    var tableModel: [FlightSection]
}

 class LikeStorage {
    var idArray: [String] = []
}
