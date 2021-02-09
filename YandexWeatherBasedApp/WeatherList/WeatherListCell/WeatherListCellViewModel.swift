//
//  WeatherListCellViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 18.01.2021.
//

import Foundation

//MARK:- Protocol

protocol WeatherListCellViewModelProtocol {
    
    var cityName: String {get}
    var temp: String {get}
    var weatherIconData: Data? {get}
    
    init(weatherInfo: YandexWeatherData?)
}

//MARK:- Class

class WeatherListCellViewModel: WeatherListCellViewModelProtocol {

    var cityName: String
    var temp: String
    var weatherIconData: Data?
    
    
    required init(weatherInfo: YandexWeatherData?) {
        
        self.cityName = weatherInfo?.geoObject.locality.name ?? "--"
        if let temp = weatherInfo?.fact.temp {
            self.temp = temp > 0 ? "+\(temp)˚C" : "\(temp)˚C"
        } else {self.temp = "0˚C"}
        self.weatherIconData = NetworkManager.shared.loadImageData(imageName: weatherInfo?.fact.icon)
    }
}


        
        
