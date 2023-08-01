//
//  LocationSearchSheet.swift
//  Weather Report
//
//  Created by MacBook on 31.07.2023.
//

import SwiftUI
import CoreLocation

struct LocationSearchSheet: View {
    
    @EnvironmentObject var viewModel: WeatherReportViewModel
    @Binding var dismiss: Bool
    @Binding var cityName: String
    
    private enum FocusedField {
        case citySearch
    }
    
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                HStack {
                    TextField("City", text: $viewModel.city)
                        .focused($focusedField, equals: .citySearch)
                        .padding()
                        .onReceive(viewModel.$city.debounce(for: 0.5, scheduler: DispatchQueue.main)
                            .filter({ $0.count >= 3 }), perform: { newValue in
                            viewModel.searchCity(for: newValue)
                        })
                        .onAppear {
                            focusedField = .citySearch
                        }
                    
                    // Inner button to clean textfield
                    Button(action: {
                        cityName = ""
                        viewModel.city = ""
                        viewModel.locations = []
                    }, label: {
                        Image(systemName: "x.circle")
                            .foregroundColor(.gray)
                            .padding(.trailing, 12)
                    })
                }
                .overlay (
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 1)
                )
                
                // Cancel button
                Button(action: {
                    dismiss.toggle()
                }, label: {
                    Text("Cancel")
                        .padding(.leading, 12)
                })
            }
            .padding([.horizontal, .top], 16)
            
            // List of found locations
            if !viewModel.locations.isEmpty {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(viewModel.locations) { location in
                            
                            Button(action: {
                                viewModel.getForecast(lat: location.latitude, lng: location.longitude)
                                cityName = location.name
                                dismiss.toggle()
                            }, label: {
                                GeocodingCell(location: location)
                            })
                            
                        }
                    }
                }
            } else if !viewModel.city.isEmpty {
                NoData()
            }
            Spacer()
        }
        .interactiveDismissDisabled(true)
    }
}

struct LocationSearchSheet_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchSheet(dismiss: .constant(true), cityName: .constant("test"))
            .environmentObject(WeatherReportViewModel())
    }
}
