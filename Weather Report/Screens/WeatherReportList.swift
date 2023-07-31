//
//  WeatherReportList.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import SwiftUI
import CoreLocation

struct WeatherReportList: View {
    
    @EnvironmentObject private var viewModel: WeatherReportViewModel
    
    @State private var searchSheet: Bool = false
    
    private var forecast: [ConvertedDailyReport] {
        viewModel.forecast
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                
                headerView
                
                if !forecast.isEmpty {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(forecast) { detail in
                                NavigationLink(destination: DetailedView()) {
                                    ForecastCell(detail: detail)
                                }
                            }
                        }
                    }
                } else if viewModel.currentLocation == nil {
                    NoCurrentLocationView()
                } else {
                    NoData()
                }
            }
            .onAppear {
                viewModel.start()
            }
        }
        .sheet(isPresented: $searchSheet, content: {
            LocationSearchSheet(dismiss: $searchSheet, cityName: $viewModel.city)
        })
    }
}

struct WeatherReportList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherReportList()
            .environmentObject(WeatherReportViewModel())
    }
}

extension WeatherReportList {
    
    var headerView: some View {
        HStack {
            Button(action: {
                searchSheet.toggle()
            }, label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 12)
                    
                    Text(viewModel.city.isEmpty ? "Forecast for current location" : viewModel.city)
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                        .padding(.leading, 8)
                    
                    Spacer()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 1)
                )
            })
            
            Button(action: {
                viewModel.cleanAndShowDefaultLocation()
            }, label: {
                Text("Clean")
                    .padding(.horizontal, 12)
            })
            .disabled(viewModel.city.isEmpty)
        }
        .padding(.horizontal)
    }
}

struct NoData: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image("sad_smile")
                .resizable()
                .frame(width: 100, height: 100)
            Text("No locations found")
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}

struct NoCurrentLocationView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image("sad_smile")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Did not get current location.\nYou can find your location manually\nby tapping on search field above")
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}
