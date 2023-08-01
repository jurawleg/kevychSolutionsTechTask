//
//  GeocodingModel.swift
//  Weather Report
//
//  Created by MacBook on 31.07.2023.
//

import Foundation

struct GeocodingResults: Codable {
    var results: [GeocodingModel]
}

struct GeocodingModel: Codable, Identifiable {
    var id: Int
    var name: String
    var latitude: CGFloat
    var longitude: CGFloat
    var country: String
    var admin1: String
    var admin2: String?
}
