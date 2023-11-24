//
//  ViewController.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/11/12.

import UIKit

struct WeatherData: Decodable {
    let weather: [Weather]
    let name: String
}

struct Weather: Decodable {
    let main: String
}

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tappedTokushima(_ sender: UIButton) {
        getWeatherFromAPI(latitude: "34.065756", longitude: "134.559297")
    }

    @IBAction func tappedTokyo(_ sender: UIButton) {
        getWeatherFromAPI(latitude: "35.689753", longitude: "139.691731")
    }

    func showAPIErrorAlert(lat: String, lon: String) {
        let alert = UIAlertController(title: "エラー", message: "通信に失敗しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "リトライ", style: .default) { (action) in
            self.getWeatherFromAPI(latitude: lat, longitude: lon)
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func getWeatherFromAPI(latitude: String, longitude: String) {

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self]
            data, response, error in
            print("self:", self)

            guard let data = data else {
                return DispatchQueue.main.async {
                    print("self:", self)
                    //🟥ここのselfってViewControllerで置き換えれないの？
                    //weakself?
                    self?.showAPIErrorAlert(lat: latitude, lon: longitude)
                }
            }

            do {
                //func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
                let decodeData = try JSONDecoder().decode(WeatherData.self, from: data)
                let description = decodeData.weather[0].main
                let cityName = decodeData.name
                DispatchQueue.main.async {
                    self?.weatherLabel.text = description
                    self?.prefectureLabel.text = cityName
                }
            } catch {
                DispatchQueue.main.async {
                    self?.showAPIErrorAlert(lat: latitude, lon: longitude)
                }
            }
        }
        task.resume()
    }
}
