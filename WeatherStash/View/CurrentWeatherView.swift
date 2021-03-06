//
//  CurrentWeatherView.swift
//  WeatherStash
//
//  Created by Goutham on 23/06/22.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var measurementType: MeasurementType
    
    var city: String
    var weather: CurrentWeather
    var hlForecast: Forecast?
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(city)
                .font(.custom("Helvetica-Neue", size: 30))
            
            Text(weather.weatherText)
                .font(.callout)
            
            Spacer()
            
            HStack {
                Text(Helper.temperatureDisplay(value: weather.temperatureValue(for: measurementType).value, unit: measurementType.option.unitTemperature))
                Text(weather.temperatureValue(for: measurementType).unit)
            }
            .font(.custom("HelveticaNeue-Light", size: 60))
            
            if let forecast = hlForecast {
                Text("H:\(Helper.temperatureDisplay(value: forecast.temprature.maximum.value, unit: .celsius)) L:\(Helper.temperatureDisplay(value: forecast.temprature.minimum.value, unit: .celsius))")
                    .font(.callout)
            }
            Spacer()
        }
        .frame(height: 160)
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(city: "Bengaluru", weather: CurrentWeather.mock())
    }
}
