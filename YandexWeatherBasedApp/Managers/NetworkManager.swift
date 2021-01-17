//
//  NetworkManager.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import Foundation

struct NetworkManager {
    
    private let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&extra=true&lang=ru_RU"
    private let apiKey = "32615584-6274-4047-9fc4-18c66b1d5040"
    private let apiField = "X-Yandex-API-Key"
    
    func  fetchData(complitionHandeler: @escaping(YandexWeatherData)->Void)  {
        
        let url = URL(string: urlString)
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.addValue(apiKey, forHTTPHeaderField: apiField)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    if let weatherData = parseJSON(withData: data) {
                    complitionHandeler(weatherData)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    private func parseJSON(withData data: Data) -> YandexWeatherData? {
        
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(YandexWeatherData.self, from: data)
            return currentWeatherData
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
