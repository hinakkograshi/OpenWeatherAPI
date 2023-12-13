//
//  ViewController.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/11/12.

import UIKit

class TokushimaViewController: UIViewController {
    private let latitude = "34.065756"
    private let longitude = "134.559297"
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tappedTokushima(_ sender: UIButton) {
        APIClient().getWeatherFromAPI(latitude: latitude, longitude: longitude) { description, cityName in
            DispatchQueue.main.async {
                self.weatherLabel.text = description
                self.prefectureLabel.text = cityName
            }
        } errorCompletionHandler: {
            DispatchQueue.main.async {
                self.showAPIErrorAlert()
            }
        }
        
    }
    
    func showAPIErrorAlert() {
        let alert = UIAlertController(title: "エラー", message: "通信に失敗しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "リトライ", style: .default) { (action) in
            APIClient().getWeatherFromAPI(latitude: self.latitude, longitude: self.longitude) { description, cityName in
                DispatchQueue.main.async {
                    self.weatherLabel.text = description
                    self.prefectureLabel.text = cityName
                }
            } errorCompletionHandler: {
                DispatchQueue.main.async {
                    self.showAPIErrorAlert()
                }
            }
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
