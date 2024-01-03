# API通信学習用ミニアプリ
Open Weather APIを使用したミニアプリです。
URL: https://openweathermap.org/current

選択した都道府県のボタンの県庁所在地の緯度と軽度を用い、API通信を行い、都道府県名・天気を取得しています。

https://github.com/hinakkograshi/OpenWeatherAPI/assets/131275914/cff91848-3f03-49f4-9a97-3b4ffb254bcb

### オブジェクト間のイベント通知方法
**クロージャを採用してます。**
クロージャによるコールバックの受け取りを実装しています。
採用理由、呼び出し元と同じ場所にコールバック処理を記述し、処理の流れを追いやすくするため。

## gitignore
gitignoreにConstants.swiftが入っています！
動かしたい場合、ご自身で取得した"APIKey"を置き換えてください！
```
struct Constants {
     static let apiKey = "APIKey"
 }
```
