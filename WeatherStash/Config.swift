//
//  Config.swift
//  WeatherStash
//
//  Created by Goutham on 20/06/22.
//

import Foundation

enum Config {
    enum AccuWeather {
        static let autocomplete = "https://dataservice.accuweather.com/locations/v1/cities/autocomplete"
        static let currentConditions = "https://dataservice.accuweather.com/currentconditions/v1/:locationKey"
        static let forecast5days = "https://dataservice.accuweather.com/forecasts/v1/daily/5day/:locationKey?metric=true"
        static let forecast12Hours = "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/:locationKey?metric=true"
    }
}
