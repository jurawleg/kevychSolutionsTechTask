//
//  ForecastModel.swift
//  Weather Report
//
//  Created by MacBook on 31.07.2023.
//

import Foundation

public struct ForecastModel: Codable {
    var latitude: CGFloat
    var longitude: CGFloat
    var daily: DailyReports
}

public struct DailyReports: Codable {
    var time: [String]
    var temperature_2m_max: [Double]
    var temperature_2m_min: [Double]
    var sunrise: [String]
    var sunset: [String]
    var windspeed_10m_max: [Double]
    var windspeed_10m_min: [Double]
}
