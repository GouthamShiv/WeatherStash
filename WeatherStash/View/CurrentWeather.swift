//
//  CurrentWeather.swift
//  WeatherStash
//
//  Created by Goutham on 23/06/22.
//

import Foundation

enum IconType: String {
    case sunny
    case partlySunny
    case partlyCloudy
    case rain
    case clear
    case snow
    case unknown
}

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

struct CurrentWeatherHourly: Codable, Identifiable {
    var id: String? = UUID().uuidString
    
    let dateTime: String
    let iconPhrase: String
    let temperature: TemperatureValue
    
    var timeStr: String {
        let dateTime = toDate(from: dateTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        
        let hourString = formatter.string(from: dateTime)
        return hourString
    }
    
    func toDate(from dateStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let date = formatter.date(from: String(dateStr.dropLast(6)))
        return date ?? Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateTime = "DateTime"
        case iconPhrase = "IconPhrase"
        case temperature = "Temperature"
    }
    
    static func mock() -> CurrentWeatherHourly {
        return CurrentWeatherHourly(dateTime: "2022-06-20T07:00:00+05:30",
                                    iconPhrase: "Thunderstorms",
                                    temperature: TemperatureValue(value: 24.6, unit: "C"))
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
    func temperatureValue(for measurementType: MeasurementType) -> TemperatureValue {
        if measurementType.option == .imperial {
            return self.temperature.imperial
        }
        
        return self.temperature.metric
    }
}
