//
//  TokyoViewController.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/11/27.
//

import UIKit

class TokyoViewController: UIViewController {
    private let latitude = "35.689753"
    private let longitude = "139.691731"
    let apiClient = APIClient()
    let alertMaker = AlertMaker()
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!

    @IBAction func tappedTokyo(_ sender: UIButton) {
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
