//
//  AppDelegate.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        LocationManager.shared.setupPermission()
        LocationManager.shared.getCurentLocation()
        
        return true
    }
    
}
