//
//  CurrentWeatherView.swift
//  WeatherStash
//
//  Created by Goutham on 23/06/22.
//

import SwiftUI

struct CurrentWeatherView: View {
    var city: String
    var weather: CurrentWeather

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(city)
                .font(.custom("Helvetica-Neue", size: 30))
            
            Text(weather.weatherText)
                .font(.callout)
            
            Text(Helper.temperatureDisplay(value: weather.temperature.metric.value, unit: .celsius) + weather.temperature.metric.unit)
                .font(.custom("HelveticaNeue-Light", size: 60))
        }
        .frame(height: 160)
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(city: "Bengaluru", weather: CurrentWeather.mock())
    }
}
