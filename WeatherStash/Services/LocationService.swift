//
//  LocationService.swift
//  WeatherStash
//
//  Created by Goutham on 21/06/22.
//

import Foundation

class LocationService: ObservableObject {
    @Published var searchResults = [Location]()
    
    var searchQuery = "" {
        didSet {
            if !searchQuery.isEmpty {
                searchLocation()
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
}
