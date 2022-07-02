//
//  WeatherStashApp.swift
//  WeatherStash
//
//  Created by Goutham on 20/06/22.
//

import SwiftUI

@main
struct WeatherStashApp: App {
    let measurementType = MeasurementType(option: .metric)

    var body: some Scene {
        let locationService = LocationService(measurementType: measurementType)
        WindowGroup {
            ContentView(locationService: locationService)
                .environmentObject(measurementType)
        }
    }
}
