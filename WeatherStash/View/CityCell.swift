//
//  CityCell.swift
//  WeatherStash
//
//  Created by Goutham on 22/06/22.
//

import SwiftUI

struct CityCell: View {
    var location: Location?
    var body: some View {
        VStack(alignment: .leading) {
            Text(location?.localizedName ?? "")
                .foregroundColor(.primary)
            Text("\(location?.administrativeArea.localizedName ?? ""), \(location?.country.localizedName ?? "")")
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
}

struct CityCell_Previews: PreviewProvider {
    static var previews: some View {
        CityCell()
    }
}
