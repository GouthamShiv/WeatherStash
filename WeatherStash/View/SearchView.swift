//
//  SearchView.swift
//  WeatherStash
//
//  Created by Goutham on 21/06/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var locationService: LocationService
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(locationService: locationService)
            }
            .navigationTitle("Search Location")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(locationService: LocationService())
    }
}
