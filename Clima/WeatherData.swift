//
//  WeatherData.swift
//  Clima
//
//  Created by Paweł Łąk on 21/05/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let weatherId: Int
    let temp: Double
    let weather: String
}

