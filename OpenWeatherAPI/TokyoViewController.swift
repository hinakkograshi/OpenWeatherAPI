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
                    //プロパティにクロージャを保存して実行を待っている！あとで呼びたい！
                    self.weatherLabel.text = description
                    self.prefectureLabel.text = cityName
                    print("データ取得完了")
                }
            },
            failure: {
                DispatchQueue.main.async {
                    self.showAPIErrorAlert()
                }
            }
        )
    }
//Viewの管轄
    //AlertControllerを
    //func makeErrorAlert(didTapRetry: () -> Void) -> UIAlertController
    //Modelじゃなくて、Viewの処理を切り出す！
    //struct AlertMaker makeErrorAlert
    func showAPIErrorAlert() {
        let alert = UIAlertController(title: "エラー", message: "通信に失敗しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "リトライ", style: .default) { (action) in
            self.showWetherView()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
