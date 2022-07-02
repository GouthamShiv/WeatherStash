//
//  FiveDayForecaseView.swift
//  WeatherStash
//
//  Created by Goutham on 26/06/22.
//

import SwiftUI

struct FiveDayForecaseView: View {
    var forecasts: [Forecast]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(forecasts, id: \.date) { forecast in
                HStack(alignment: .center, spacing: 10) {
                    Text(Helper.day(from: forecast.date))
                        .font(.title3)
                        .frame(width: 110, alignment: .leading)
                    
                    Spacer()
                    Image(Helper.iconName(phrase: forecast.day.iconPhrase))
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Text("\(Int(forecast.temprature.maximum.value))")
                            .frame(width: 30, alignment: .leading)

                        Text("\(Int(forecast.temprature.minimum.value))")
                            .frame(width: 30, alignment: .leading)
                            .opacity(0.5)
                    }
                    .frame(width: 100, alignment: .trailing)
                }
            }
        }
        .padding()
    }
}

struct FiveDayForecaseView_Previews: PreviewProvider {
    static var previews: some View {
        FiveDayForecaseView(forecasts: [Forecast.mock()])
    }
}
