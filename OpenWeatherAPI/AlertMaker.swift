//
//  AlertMaker.swift
//  OpenWeatherAPI
//
//  Created by Hina on 2023/12/16.
//

import UIKit

//メソッドのより良い名前を考える！
struct AlertMaker {
    func createUIAlertController(didTapRetry: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "エラー", message: "通信に失敗しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "リトライ", style: .default, handler: {(action) -> Void in
            didTapRetry()
        })
        alert.addAction(action)
        return alert
    }
}
