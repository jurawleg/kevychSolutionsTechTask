//
//  GeocodingCell.swift
//  Weather Report
//
//  Created by MacBook on 31.07.2023.
//

import SwiftUI

struct GeocodingCell: View {
    
    private var location: GeocodingModel
    
    public init(location: GeocodingModel) {
        self.location = location
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomTextView(title: "Name", value: location.name)
            CustomTextView(title: "Lat", value: location.latitude)
            CustomTextView(title: "Lng", value: location.longitude)
            CustomTextView(title: "Country", value: location.country)
            CustomTextView(title: "Admin 1", value: location.admin1)
            CustomTextView(title: "Admin 2", value: location.admin2 ?? "no data")
        }
        .fillWidth()
        .background(Color.yellow)
        .padding(.horizontal, 16)
    }
}

struct GeocodingCell_Previews: PreviewProvider {
    static var previews: some View {
        GeocodingCell(location: .init(id: 123, name: "Some city", latitude: 67.89, longitude: 12.34, country: "USA", admin1: "Admin 1") )
    }
}
