//
//  ContentView.swift
//  WeatherStash
//
//  Created by Goutham on 20/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var toogleSearchLocation = false
    @ObservedObject var locationService = LocationService()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack(alignment: .center) {
                    Image(locationService.currentWeather?.isDayTime ?? true ? "bgDay" : "bgNight")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height)
                    
                    VStack {
                        if let location = locationService.selectedLocation,
                           let weather = locationService.currentWeather {
                            // Text("Key: \(location.key) - Name: \(location.localizedName)")
                            CurrentWeatherView(city: location.localizedName,
                                               weather: weather,
                                               hlForecast: locationService.forecasts.first)
                            Divider()
                                .background(Color.white)
                            
                            HourlyForecastView(hourlyForecasts: locationService.hourlyForecast)
                            
                            Divider()
                                .background(Color.white)
                            
                            FiveDayForecaseView(forecasts: locationService.forecasts)
                            
                            Spacer()
                        }
                        else {
                            VStack(alignment: .center, spacing: 20) {
                                Image(systemName: "thermometer")
                                    .resizable()
                                    .frame(width: 60, height: 100, alignment: .center)
                                
                                Text("Search for a city to display the weather")
                            }
                            .frame(width: geo.size.width)
                            
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .toolbar(content: {
                        Button(action: {
                            toogleSearchLocation.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .trailing)
                                .foregroundColor(.white)
                        })
                    })
                }
                .sheet(isPresented: $toogleSearchLocation, content: {
                    SearchView(locationService: locationService)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
