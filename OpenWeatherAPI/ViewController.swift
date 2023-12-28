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
    //Segue遷移先がすぐわかる

    //Push遷移はナビゲージョンコントローラー
    @IBAction func TapTokushimaButton(_ sender: UIButton) {
        let weatherVC = UIStoryboard(name: "WeatherView", bundle: nil).instantiateViewController(withIdentifier: "WeatherView") as! WeatherViewController
        weatherVC.latitude = tokushimaLatitude
        weatherVC.longitude = tokushimaLongitude
        self.present(weatherVC, animated: true, completion: nil)
    }
    
    @IBAction func TapTokyoButton(_ sender: UIButton) {
        let weatherVC = UIStoryboard(name: "WeatherView", bundle: nil).instantiateViewController(withIdentifier: "WeatherView") as! WeatherViewController
        weatherVC.latitude = tokyoLatitude
        weatherVC.longitude = tokyoLongitude
        self.present(weatherVC, animated: true, completion: nil)
    }
    

    @IBAction func TapHokkaidoButton(_ sender: UIButton) {
        let weatherVC = UIStoryboard(name: "WeatherView", bundle: nil).instantiateViewController(withIdentifier: "WeatherView") as! WeatherViewController
        weatherVC.latitude = hokkaidoLatitude
        weatherVC.longitude = hokkaidoLongitude
        self.present(weatherVC, animated: true, completion: nil)
    }
}
