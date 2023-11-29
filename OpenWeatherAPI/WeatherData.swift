//
//  WeatherData.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/11/27.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let name: String
}

struct Weather: Decodable {
    let main: String
}
