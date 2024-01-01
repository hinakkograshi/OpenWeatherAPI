//
//  ViewController.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/11/12.

import UIKit

class WeatherViewController: UIViewController {
    var latitude = ""
    var longitude = ""

    let apiClient = APIClient()
    let alertMaker = AlertMaker()

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    static func instanciate() -> WeatherViewController {
        UIStoryboard(name: "WeatherView", bundle: nil).instantiateViewController(withIdentifier: "WeatherView") as! WeatherViewController
    }

    @IBAction func tappedFetchWeather(_ sender: UIButton) {
        showWeatherView()
    }

    func showWeatherView() {
        apiClient.getWeatherFromAPI(
            latitude: latitude,
            longitude: longitude,
            success: { description, cityName in
                DispatchQueue.main.async {
                    self.weatherLabel.text = description
                    self.prefectureLabel.text = cityName
                }
            },
            failure: {
                DispatchQueue.main.async {
                    let alert = self.alertMaker.make(didTapRetry: {
                        self.showWeatherView()
                    })
                    self.showWeatherView()
                    self.present(alert, animated: true, completion: nil)
                }
            }
        )
    }
}
