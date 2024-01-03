//
//  ViewController.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/12/28.
//

import UIKit

class ViewController: UIViewController {
    let hokkaidoLatitude = "43.064301"
    let hokkaidoLongitude = "141.346874"

    let tokyoLatitude = "35.689753"
    let tokyoLongitude = "139.691731"

    let tokushimaLatitude = "34.065756"
    let tokushimaLongitude = "134.559297"

    @IBAction func TapTokushimaButton(_ sender: UIButton) {
        let weatherVC = WeatherViewController.instanciate()
        weatherVC.latitude = tokushimaLatitude
        weatherVC.longitude = tokushimaLongitude
        navigationController?.pushViewController(weatherVC, animated: true)
    }

    @IBAction func TapTokyoButton(_ sender: UIButton) {
        let weatherVC = WeatherViewController.instanciate()
        weatherVC.latitude = tokyoLatitude
        weatherVC.longitude = tokyoLongitude
        navigationController?.pushViewController(weatherVC, animated: true)
    }

    @IBAction func TapHokkaidoButton(_ sender: UIButton) {
        let weatherVC = WeatherViewController.instanciate()
        weatherVC.latitude = hokkaidoLatitude
        weatherVC.longitude = hokkaidoLongitude
        navigationController?.pushViewController(weatherVC, animated: true)
    }
}
