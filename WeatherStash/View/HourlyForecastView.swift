//
//  HourlyForecastView.swift
//  WeatherStash
//
//  Created by Goutham on 26/06/22.
//

import SwiftUI

struct HourlyForecastView: View {
    var hourlyForecasts: [CurrentWeatherHourly]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                ForEach(hourlyForecasts, id: \.dateTime) { hourly in
                    VStack(alignment: .center, spacing: 5) {
                        Text(hourly.timeStr)
                        Image(Helper.iconName(phrase: hourly.iconPhrase))
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                        Text(Helper.temperatureDisplay(value: hourly.temperature.value, unit: .celsius))
                    }
                }
            }
        }
        .frame(height: 100)
        .padding(.horizontal, 15)
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView(hourlyForecasts: [CurrentWeatherHourly.mock()])
    }
}
