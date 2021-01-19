//
//  WeatherListCellViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 18.01.2021.
//

import Foundation

protocol WeatherListCellViewModelProtocol {
    
    var cityName: String {get}
    var temp: String {get}
    var imageData: Data? {get}
    
    init(weatherInfo: YandexWeatherData)
}

class WeatherListCellViewModel: WeatherListCellViewModelProtocol {

    var cityName: String
    
    var temp: String
    
    var imageData: Data?
    
    required init(weatherInfo: YandexWeatherData) {
        
        self.cityName = weatherInfo.geoObject.locality.name ?? "Неопознанный город"
        self.imageData = NetworkManager.shared.loadImageData(imageName: weatherInfo.fact.icon ?? "ovc")
        self.temp = String(weatherInfo.fact.temp ?? 25) + "˚C"
    }
}


        
        
