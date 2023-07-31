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
    var temperature_2m_max: [CGFloat]
    var temperature_2m_min: [CGFloat]
    var sunrise: [String]
    var sunset: [String]
    var windspeed_10m_max: [CGFloat]
    
    var itemsCount: Int {
        return time.count
    }
}

public struct ConvertedDailyReport: Identifiable {
    public var id: String = UUID().uuidString
    public var time: String
    public var temperature_2m_max: CGFloat
    public var temperature_2m_min: CGFloat
    public var sunrise: String
    public var sunset: String
    public var windspeed_10m_max: CGFloat
}
