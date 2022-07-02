//
//  SearchView.swift
//  WeatherStash
//
//  Created by Goutham on 21/06/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var locationService: LocationService
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(locationService: locationService)
                
                List(locationService.searchResults, id: \.key) { result in
                    CityCell(location: result, selectedLocation: $locationService.selectedLocation)
                }
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Search Location")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(locationService: LocationService(measurementType: MeasurementType(option: .metric)))
    }
}
