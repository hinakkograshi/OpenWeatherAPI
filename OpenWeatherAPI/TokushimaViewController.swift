//
//  ViewController.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/11/12.

import UIKit

class TokushimaViewController: UIViewController {
    private let latitude = "34.065756"
    private let longitude = "134.559297"
    let apiClient = APIClient()
    let alertMaker = AlertMaker()

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!

    @IBAction func tappedTokushima(_ sender: UIButton) {
        showWetherView()
    }

    func showWetherView() {
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
                    let alert = self.alertMaker.showAPIErrorAlert {
                        self.showWetherView()
                    }
                    self.present(alert, animated: true, completion: nil)
                }
            }
        )
    }
}
