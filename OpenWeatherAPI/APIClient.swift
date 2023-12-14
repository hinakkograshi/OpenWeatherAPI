//
//  APIClient.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/12/10.
//

import Foundation

struct APIClient {//succes,failer identifierは何使ってもいいが、わかりやすい名前
    func getWeatherFromAPI(latitude: String, longitude: String, completionHandler: @escaping (String, String) -> Void, errorCompletionHandler: @escaping () -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print("クロージャ実行開始")
            //同じ名前　ショートハンド
            guard let data else {
                errorCompletionHandler()
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(WeatherData.self, from: data)
                let description = decodeData.weather[0].main
                let cityName = decodeData.name
                //Voidなので何も返さない！
                completionHandler(description, cityName)

            } catch {
                errorCompletionHandler()
            }
        }
        task.resume()
        print("関数終了")
    }
}
