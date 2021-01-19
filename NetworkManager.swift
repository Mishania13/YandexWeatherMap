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
    private let imageUrlString = "https://yastatic.net/weather/i/icons/blueye/color/svg/"
    
    private let apiKey = "32615584-6274-4047-9fc4-18c66b1d5040"
    private let apiField = "X-Yandex-API-Key"
    private let latitudeField = "&lat="
    private let longitudeField = "&lon="
    
    private let locationManager = LocationManager()
    
    func fetchData(forCity city: String, complitionHandeler: @escaping(YandexWeatherData)->Void)  {
        
        var urlString = self.urlString
        
        locationManager.getCoordinate(forCity: city) { (coordinate) in
            urlString += self.latitudeField + coordinate.latitude
            urlString += self.longitudeField + coordinate.longitude
            
            guard let url = URL(string: urlString) else {return}
            var request = URLRequest(url: url)
            request.addValue(self.apiKey, forHTTPHeaderField: self.apiField)
            
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                }
                
                if let data = data {
                    guard let weatherData = self.parseJSON(withData: data) else {return}
                    DispatchQueue.main.async {
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
            print(error)
        }
        return nil
    }
    
    func loadImageData(imageName: String) -> Data? {
        
        let urlString = self.imageUrlString + imageName + ".svg"
        
        guard let url = URL(string: urlString) else {return nil}
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
}
