//
//  MeasurementType.swift
//  WeatherStash
//
//  Created by Goutham S on 02/07/22.
//

import Foundation

enum MeasurementTypeOption {
  case metric
  case imperial
  
  var unitTemperature: UnitTemperature {
    switch self {
    case .imperial:
      return .fahrenheit
    case .metric:
      return .celsius
    }
  }
}

class MeasurementType: ObservableObject {
  var option: MeasurementTypeOption
  
  init(option: MeasurementTypeOption) {
    self.option = option
  }
}
