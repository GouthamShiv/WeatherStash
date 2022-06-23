//
//  Forecast.swift
//  WeatherStash
//
//  Created by Goutham on 23/06/22.
//

import Foundation

struct ForecastResponse: Codable {
    let dailyForecasts: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct Forecast: Codable, Identifiable {
    var id: String? = UUID().uuidString
    let date: String
    let temprature: Temperature
    let day: WeatherPhrase
    let night: WeatherPhrase
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "Date"
        case temprature = "Temperature"
        case day = "Day"
        case night = "Night"
    }
    
    struct Temperature: Codable {
        let minimum: TemperatureValue
        let maximum: TemperatureValue
        
        enum CodingKeys: String, CodingKey {
            case minimum = "Minimum"
            case maximum = "Maximum"
        }
    }
    
    struct WeatherPhrase: Codable {
        let iconPhrase: String
        
        enum CodingKeys: String, CodingKey {
            case iconPhrase = "IconPhrase"
        }
    }
}

extension Forecast {
    static func mock() -> Forecast {
        return Forecast(date: "2022-06-20T07:00:00+05:30",
                        temprature: Forecast.Temperature(
                            minimum: TemperatureValue(value: 20.4, unit: "C"),
                            maximum: TemperatureValue(value: 27.5, unit: "C")),
                        day: Forecast.WeatherPhrase(iconPhrase: "Thunderstorms"),
                        night: Forecast.WeatherPhrase(iconPhrase: "Thunderstorms"))
    }
}
