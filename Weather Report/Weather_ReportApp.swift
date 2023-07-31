//
//  Weather_ReportApp.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import SwiftUI

@main
struct Weather_ReportApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            WeatherReportList()
        }
    }
}
