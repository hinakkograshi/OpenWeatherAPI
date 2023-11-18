//
//  ViewController.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/11/12.

import UIKit

//JSONデータを取り込むSwift型
struct WeatherData: Decodable {
    let weather: [Weather]
    let name: String
}

struct Weather: Decodable {
    let main: String
}

enum APIError: Error {
    case networkError
    case unknown
    //ローバリューじゃなく、コンピュータープロパティ
    var title: String {
        //`self`: APIError
        //型内部で、selfキーワードを通じ、インスタンス自身にアクセス
        //ゲッタ、セッタは省略
        switch self {
        case .networkError:
            //値を保持せずに算出した値を返すプロパティ
            return "通信エラー"
        case .unknown:
            return "URLエラー"
        }
    }

    var description: String {
        switch self {
        case .networkError:
            return "通信環境の良いところでもう一度お試しください。"

        case .unknown:
            return "指定した緯度と経度の都道府県が見つかりませんでした。"
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!

    @IBOutlet weak var prefectureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherFromAPI()
    }
    func showAPIErrorAlert(error: APIError) {

        let alert = UIAlertController(title: error.title, message: error.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "リトライ", style: .default) { (action) in
            self.getWeatherFromAPI()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    //英語で伝わるように
    func getWeatherFromAPI() {
        //SwiftAPIガイドラインフル
        //        34.065756 String or Int
        let latitude = 34.065756
        let longitude = 134.559297
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)"
        //指定された文字列から URL インスタンスを作成
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self]
            data, response, error in
            //データはnilじゃない。エラーがnil
            //データがnilでエラーがnilじゃない
            //            print("##Data:",error)
            guard let data = data else{
                return DispatchQueue.main.async {
                    //ここのselfってViewController????
                    self?.showAPIErrorAlert(error: APIError.networkError)} }
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
                print("##Data",error)
                DispatchQueue.main.async {
                    self?.showAPIErrorAlert(error: .unknown)
                }
            }
        }
        task.resume()
    }
}
