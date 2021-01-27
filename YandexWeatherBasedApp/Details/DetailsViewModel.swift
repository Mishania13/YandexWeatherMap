//
//  DetailsViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 25.01.2021.
//

import Foundation

//MARK: - Protocol

protocol DetailsViewModelProtocol {
    
    var cityName: String {get}
    var currentTemp: String {get}
    var feelsLikeTemp: String {get}
    var humidity: String {get}
    var windSpeed: String {get}
    var pressure: String {get}
    
    func windDir() -> String
    
    init(cityWeatherData: YandexWeatherData)
}

//MARK: - Class

class DetailsViewModel: DetailsViewModelProtocol {
    
    var cityWeatherData: YandexWeatherData
    var cityName: String {
        get {
            guard let name = cityWeatherData.geoObject.locality.name else {return "--"}
            return name
        }
    }
    var currentTemp: String {
        get {
            guard let temp = cityWeatherData.fact.temp else {return "--"}
            switch temp {
            case 1...99: return "+\(temp)˚C"
            case 0: return "0˚C"
            default: return "\(temp)˚C"
            }
        }
    }
    var feelsLikeTemp: String {
        get {
            guard let temp = cityWeatherData.fact.feelsLike else {return "--"}
            switch temp {
            case 1...99: return "Ощущается как: +\(temp)˚C"
            case 0: return "Ощущается как: 0˚C"
            default: return "Ощущается как: \(temp)˚C"
            }
        }
    }
    var humidity: String {
        get {
            guard let humidity = cityWeatherData.fact.humidity else {return "--"}
            return "Влажность: \(humidity)%"
        }
    }
    var windSpeed: String {
        get {
            guard let windSpeed = cityWeatherData.fact.windSpeed else {return "--"}
            return "Ветер: \(Int(windSpeed)) м/c \(windDir())"
        }
    }
    var pressure: String {
        get {
            guard let pressure = cityWeatherData.fact.pressureMm else {return "--"}
            return "Давление: \(pressure) мм рт. ст"
        }
    }

    
    required init(cityWeatherData: YandexWeatherData) {
        self.cityWeatherData = cityWeatherData
    }
    
    func windDir() -> String {
        guard let windDir = cityWeatherData.fact.windDir else {return "--"}
        
        switch windDir {
        
        case "nw": return "СЗ"
        case "n": return"С"
        case "ne": return "СВ"
        case "e": return "В"
        case "ca": return "ЮВ"
        case "s": return "Ю"
        case "sw": return "ЮЗ"
        case "w": return "З"
        default: return ""
        }
    }
}


