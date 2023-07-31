//
//  ForecastCell.swift
//  Weather Report
//
//  Created by MacBook on 31.07.2023.
//

import SwiftUI

struct ForecastCell: View {
    
    private var forecastDetail: ConvertedDailyReport
    
    public init(detail: ConvertedDailyReport) {
        self.forecastDetail = detail
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CustomTextView(title: "Date", value: forecastDetail.time)
            CustomTextView(title: "Sunrise", value: forecastDetail.sunrise)
            CustomTextView(title: "Sunset", value: forecastDetail.sunset)
            CustomTextView(title: "Max temperature", value: forecastDetail.temperature_2m_max)
            CustomTextView(title: "Min temperature", value: forecastDetail.temperature_2m_min)
            CustomTextView(title: "Wind speed", value: forecastDetail.windspeed_10m_max)
        }
        .padding(.all, 8)
        .fillWidth()
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(.gray, lineWidth: 1)
        }
        .padding(.horizontal, 16)
    }
}

struct ForecastCell_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCell(detail: .init(time: "some time", temperature_2m_max: 20, temperature_2m_min: 12, sunrise: "Sunrise", sunset: "Sunset", windspeed_10m_max: 1.2))
    }
}

struct DetailedView: View {
    var body: some View {
        Text("DETAILS")
    }
}
