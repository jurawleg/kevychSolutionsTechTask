//
//  WeatherViewModel.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import Foundation

@MainActor class WeatherReportViewModel: ObservableObject {
    
    @Published var repository: WeatherRepository = .init()
    
}
