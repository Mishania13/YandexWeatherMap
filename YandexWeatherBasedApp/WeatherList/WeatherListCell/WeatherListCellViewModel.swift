//
//  WeatherListCellViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 18.01.2021.
//

import Foundation
import SVGKit

//MARK:- Protocol

protocol WeatherListCellViewModelProtocol {
    
    var cityName: String {get}
    var temp: String {get}
    var weatherIcon: SVGKImage? {get}
    
    init(weatherInfo: YandexWeatherData?)
}

//MARK:- Class

class WeatherListCellViewModel: WeatherListCellViewModelProtocol {

    var cityName: String
    var temp: String
    var weatherIcon: SVGKImage?
    
    required init(weatherInfo: YandexWeatherData?) {
        
        self.cityName = weatherInfo?.geoObject.locality.name ?? "Неопознанный город"
        self.temp = String(weatherInfo?.fact.temp ?? 00) + "˚C"
        self.weatherIcon = NetworkManager.shared.loadSVGImage(imageName: "\(weatherInfo?.fact.icon ?? "ovc")")
    }
}


        
        
