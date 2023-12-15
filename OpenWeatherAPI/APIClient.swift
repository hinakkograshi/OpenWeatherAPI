//
//  APIClient.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/12/10.
//

import Foundation

struct APIClient {//succes,failer identifierは何使ってもいいが、わかりやすい名前
    func getWeatherFromAPI(latitude: String, longitude: String, success: @escaping (String, String) -> Void, failure: @escaping () -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print("クロージャ実行開始")
            //同じ名前　ショートハンド
            guard let data else {
                failure()
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(WeatherData.self, from: data)
                let description = decodeData.weather[0].main
                let cityName = decodeData.name
                //Voidなので何も返さない！
                success(description, cityName)

            } catch {
                failure()
            }
        }
        task.resume()
        print("関数終了")
    }
}
