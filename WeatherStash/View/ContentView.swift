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
        NavigationView {
            VStack {
                if let location = locationService.selectedLocation {
                    Text("Key: \(location.key) - Name: \(location.localizedName)")
                }
            }
            .toolbar(content: {
                Button(action: {
                    toogleSearchLocation.toggle()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .trailing)
                })
            })
        }
        .sheet(isPresented: $toogleSearchLocation, content: {
            SearchView(locationService: locationService)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
