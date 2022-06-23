//
//  CurrentWeather.swift
//  WeatherStash
//
//  Created by Goutham on 23/06/22.
//

import Foundation

struct CurrentWeather: Codable {
    
    let weatherText: String
    let isDayTime: Bool
    let temperature: TemperatureUnit
    
    enum CodingKeys: String, CodingKey {
        case weatherText = "WeatherText"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
    }
    
    struct TemperatureUnit: Codable {
        let metric: TemperatureValue
        let imperial: TemperatureValue
        
        enum CodingKeys: String, CodingKey {
            case metric = "Metric"
            case imperial = "Imperial"
        }
    }
}

struct TemperatureValue: Codable {
    let value: Double
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}

extension CurrentWeather {
    static func mock() -> CurrentWeather {
        return CurrentWeather(weatherText: "Rain",
                              isDayTime: true,
                              temperature: CurrentWeather.TemperatureUnit(
                                metric: TemperatureValue(value: 23, unit: "C"),
                                imperial: TemperatureValue(value: 73.4, unit: "F")))
    }
}
