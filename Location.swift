//
//  Location.swift
//  WeatherStash
//
//  Created by Goutham on 20/06/22.
//

import Foundation

struct Location: Codable, Identifiable {
    var id: String? = UUID().uuidString
    
    let key: String
    let localizedName: String
    let country: Country
    let administrativeArea: State
    
    struct Country: Codable {
        let localizedName: String
        enum CodingKeys: String, CodingKey {
            case localizedName = "LocalizedName"
        }
    }
    
    struct State: Codable {
        let localizedName: String
        enum CodingKeys: String, CodingKey {
            case localizedName = "LocalizedName"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case key = "Key"
        case localizedName = "LocalizedName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
}

extension Location {
    static func mock() -> Location {
        return Location(
            key: "123456",
            localizedName: "Bengaluru",
            country: Location.Country(localizedName: "India"),
            administrativeArea: Location.State(localizedName: "Karnataka"))
    }
}
