//
//  WeatherData.swift
//  Clima
//
//  Created by juyeong koh on 2022/09/15.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Codable {
    // 내 속성 이름이 JSONData에서 보고 있는 속성의 이름과 일치하는지 확인해야 함
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
