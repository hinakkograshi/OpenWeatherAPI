//
//  APIClient.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/12/10.
//

import Foundation

struct APIClient {
    func getWeatherFromAPI(latitude: String, longitude: String, success: @escaping (String, String) -> Void, failure: @escaping () -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data else {
                failure()
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(WeatherData.self, from: data)
                let description = decodeData.weather[0].main
                let cityName = decodeData.name
                success(description, cityName)

            } catch {
                failure()
            }
        }
        task.resume()
    }
}
