//
//  NetworkManager.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlString = "https://api.weather.yandex.ru/v2/forecast?"
    private let apiKey = "32615584-6274-4047-9fc4-18c66b1d5040"
    private let apiField = "X-Yandex-API-Key"
    private let latitudeField = "&lat="
    private let longitudeField = "&lon="
    
    private let imageUrlString = "https://yastatic.net/weather/i/icons/blueye/color/svg/"
    
    private let locationManager = LocationManager()
    
    func fetchWeatherForCities (for cities: [String], completionHandler: @escaping ([YandexWeatherData]) -> Void) {
       
        var dataArray: [YandexWeatherData] = []
        let group = DispatchGroup()

        for city in cities {
            group.enter()

            var urlString = self.urlString

            self.locationManager.getCoordinate(forCity: city) { (coordinate) in
                guard let coordinate = coordinate  else {
                    group.leave()
                    return
                }
                urlString += self.latitudeField + coordinate.latitude
                urlString += self.longitudeField + coordinate.longitude

                guard let url = URL(string: urlString) else {
                    group.leave()
                    return
                }

                var request = URLRequest(url: url)
                request.addValue(self.apiKey, forHTTPHeaderField: self.apiField)

                let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard
                        let data = data,
                        error == nil,
                        let weatherData = self.parseJSON(withData: data)
                    else {
                        group.leave()
                        print(error ?? "unknown error")
                        return
                    }
                    dataArray.append(weatherData)

                    group.leave()
                }
                dataTask.resume()
            }
        }
        group.notify(queue: .main) {
            completionHandler(dataArray)
        }
    }
    
    private func parseJSON(withData data: Data) -> YandexWeatherData? {
        
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(YandexWeatherData.self, from: data)
            return currentWeatherData
            
        } catch let error as NSError {
            print(error)
        }
        return nil
    }

}

//MARK:- SVG Loader
extension NetworkManager {
    
    func loadImageData(imageName: String?) -> Data? {
        
        
        let urlString = self.imageUrlString + (imageName ?? "ovc") + ".svg"
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
}
