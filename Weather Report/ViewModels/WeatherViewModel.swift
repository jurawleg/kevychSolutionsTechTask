//
//  WeatherViewModel.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import Foundation
import CoreLocation

@MainActor
final class WeatherReportViewModel: ObservableObject {
    
    @Published var forecast: [ConvertedDailyReport] = []
    @Published var currentLocation: CLLocation?
    @Published var choosenLocation: CLLocation?
    @Published var city: String = ""
    @Published var locations: [GeocodingModel] = []
    
    private var locationManager: LocationManager
    private var networkCaller: NetworkCaller = .init()
    
    init() {
        self.locationManager = LocationManager()
        locationManager.setupPermission()
        locationManager.getCurentLocation()
    }
    
    func start() {
        currentLocation = CLLocation(latitude: 0, longitude: 0)
        getForecast(lat: currentLocation!.coordinate.latitude, lng: currentLocation!.coordinate.longitude)
        return
        
        guard let currentLocation else {
            debugPrint("CurrentLocation is nil, skip getting forecast for default location")
            return
        }
        
        getForecast(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude)
        
    }
    
    func getForecast(lat: CGFloat, lng: CGFloat) {
        networkCaller.getForecast(lat: lat, lng: lng, completion: { result in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.forecast = self.getConvertedModels(forecastModel: forecast)
                }
            case .failure(let error):
                debugPrint("Failed get forecast for \(lat), \(lng). Error - \(error)")
            }
        })
    }
    
    private func getConvertedModels(forecastModel: ForecastModel) -> [ConvertedDailyReport] {
        var converted: [ConvertedDailyReport] = []
        
        let item = forecastModel.daily
        
        for count in 0..<item.itemsCount {
            let convertedReport = ConvertedDailyReport(time: item.time[count],
                                                       temperature_2m_max: item.temperature_2m_max[count],
                                                       temperature_2m_min: item.temperature_2m_min[count],
                                                       sunrise: item.sunrise[count],
                                                       sunset: item.sunset[count],
                                                       windspeed_10m_max: item.windspeed_10m_max[count])
            converted.append(convertedReport)
        }
        
        return converted
    }
    
    func searchCity(for text: String) {
        networkCaller.searchCity(for: text, completion: { result in
            switch result {
            case .failure(let error):
                debugPrint("Failed get location. Error - \(error).")
                DispatchQueue.main.async {
                    self.locations = []                    
                }
            case .success(let cities):
                DispatchQueue.main.async {
                    self.locations = cities.results
                }
            }
        })
    }
    
    func cleanAndShowDefaultLocation() {
        guard let currentLocation else {
            return
        }
        
        self.choosenLocation = nil
        self.locations = []
        self.city = ""
        
        // TODO: Implement cash!
        getForecast(lat: CGFloat(currentLocation.coordinate.latitude), lng: CGFloat(currentLocation.coordinate.longitude))
    }
}
