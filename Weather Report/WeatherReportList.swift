//
//  WeatherReportList.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import SwiftUI

struct WeatherReportList: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct WeatherReportList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherReportList()
    }
}
