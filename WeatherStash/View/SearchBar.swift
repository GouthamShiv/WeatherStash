//
//  SearchBar.swift
//  WeatherStash
//
//  Created by Goutham on 21/06/22.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var locationService: LocationService
    @State private var searchText: String = ""
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Enter location", text: $searchText)
                .onSubmit {
                    locationService.searchQuery = searchText
                }
                .onChange(of: searchText, perform: {
                    if $0.isEmpty {
                        locationService.searchQuery = ""
                    }
                })
                .foregroundColor(.primary)
            
            Button(action: {
                self.searchText = ""
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .opacity(searchText == "" ? 0 : 1)
            })
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .foregroundColor(.gray)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
        .padding(10.0)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(locationService: LocationService())
    }
}
