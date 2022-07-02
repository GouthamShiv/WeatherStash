//
//  LocationService.swift
//  WeatherStash
//
//  Created by Goutham on 21/06/22.
//

import Foundation

class LocationService: ObservableObject {
    @Published var searchResults = [Location]()
    @Published var selectedLocation: Location? {
        didSet {
            if let _ = selectedLocation {
                getCurrentCondition()
                getHourlyForecasts()
                getForecasts()
            }
        }
    }
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyForecast = [CurrentWeatherHourly]()
    @Published var forecasts = [Forecast]()
    
    var searchQuery = "" {
        didSet {
            if !searchQuery.isEmpty {
                searchLocation()
            } else {
                searchResults.removeAll()
            }
        }
    }
    
    func searchLocation() {
        searchResults = []
        
        guard let query = searchQuery
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "\(Config.AccuWeather.autocomplete)?apikey=\(Config.AccuWeather.apiKey)&q=\(query)")
        else {
            return
        }
        
        let request = URLRequest (url: url)
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode([Location].self, from: data)
                DispatchQueue.main.async {
                    self?.searchResults = response
                }
            }
            catch let error {
                print("⛔️ Error parsing location: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getCurrentCondition() {
        guard let query = selectedLocation,
              let url = URL(string: "\(Config.AccuWeather.currentConditions)/\(query.key)?apikey=\(Config.AccuWeather.apiKey)")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode([CurrentWeather].self, from: data).first
                DispatchQueue.main.async {
                    self?.currentWeather = response
                }
            }
            catch let error {
                print("⛔️ Error parsing current weather: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getHourlyForecasts() {
        guard let query = selectedLocation,
              let url = URL(string: "\(Config.AccuWeather.forecast12Hours)/\(query.key)?metric=true&apikey=\(Config.AccuWeather.apiKey)")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode([CurrentWeatherHourly].self, from: data)
                DispatchQueue.main.async {
                    self?.hourlyForecast = response
                }
            }
            catch let error {
                print("⛔️ Error parsing current weather: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getForecasts() {
        guard let query = selectedLocation,
              let url = URL(string: "\(Config.AccuWeather.forecast5days)/\(query.key)?metric=true&apikey=\(Config.AccuWeather.apiKey)")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(ForecastResponse.self, from: data)
                let forecasts = response.dailyForecasts
                
                DispatchQueue.main.async {
                    self?.forecasts = forecasts
                }
            }
            catch let error {
                print("⛔️ Error parsing current weather: \(error.localizedDescription)")
            }
        }.resume()
    }
}
