//
//  DetailsViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 25.01.2021.
//

import Foundation

//MARK: - Protocol

protocol DetailsViewModelProtocol {
    var cityWeatherData: YandexWeatherData? {get}
    var cityName: String {get}
    var currentTemp: String {get}
    var feelsLikeTemp: String {get}
    var humidity: String {get}
    var windSpeed: String {get}
    var pressure: String {get}
    var weatherIconData: Data? {get}
    var forecastImagesData: [Data?] {get}
    
    func windDir() -> String
    
    func detailsCellViewModel(at indexPath: IndexPath) -> DetailsListCellViewModelProtocol?
    
    func numberOfRowsAtTableView() -> Int
    
    init(cityWeatherData: YandexWeatherData?)
}

//MARK: - Class

class DetailsViewModel: DetailsViewModelProtocol {
    
    
    var cityWeatherData: YandexWeatherData?
    
    var cityName: String {
        cityWeatherData?.geoObject.locality.name ?? ""
    }
    
    var currentTemp: String {
        
        guard let temp = cityWeatherData?.fact.temp else {return "--"}
        switch temp {
        case 1...99: return "+\(temp)˚C"
        case 0: return "0˚C"
        default: return "\(temp)˚C"
        }
    }
    
    var feelsLikeTemp: String {
        
        guard let temp = cityWeatherData?.fact.feelsLike else {return "--"}
        switch temp {
        case 1...99: return "Ощущается как: +\(temp)˚C"
        case 0: return "Ощущается как: 0˚C"
        default: return "Ощущается как: \(temp)˚C"
        }
    }
    
    var humidity: String {
        
        guard let humidity = cityWeatherData?.fact.humidity else {return "--"}
        return "\(humidity)%"
    }
    
    var windSpeed: String {
        
        guard let windSpeed = cityWeatherData?.fact.windSpeed else {return "--"}
        return "\(Int(windSpeed)) м/c, \(windDir())"
    }
    
    var pressure: String {
        
        guard let pressure = cityWeatherData?.fact.pressureMm else {return "--"}
        return "\(pressure) мм рт. ст"
    }
    
    var weatherIconData: Data?{
        NetworkManager.shared.loadImageData(imageName: cityWeatherData?.fact.icon)
    }
    
    var forecastImagesData: [Data?]
    
    required init(cityWeatherData: YandexWeatherData?) {
        self.cityWeatherData = cityWeatherData
        forecastImagesData = []
    }
    
    //indexPath.row + 1 т.к. пропускаем сегодня
    func detailsCellViewModel(at indexPath: IndexPath) -> DetailsListCellViewModelProtocol? {
        if forecastImagesData.count > indexPath.row {
         
            return DetailsListCellViewModel(forecast: cityWeatherData?.forecasts[indexPath.row + 1], conditionImageData: forecastImagesData[indexPath.row])
        }
        return nil
    }
    
    func numberOfRowsAtTableView () -> Int {
        return cityWeatherData?.forecasts.count ?? 2 - 1
    }
    
    func windDir() -> String {
        guard let windDir = cityWeatherData?.fact.windDir else {return "--"}
        
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
    
    func returnIconsData () {
        
        if let _ = cityWeatherData?.forecasts {
            
            var forecasts = cityWeatherData!.forecasts
            forecasts.remove(at: 0)
            var imagesData: [Data?] = []
            forecasts.forEach{
                imagesData.append(NetworkManager.shared.loadImageData(imageName: ($0.parts.dayShort.icon)!))
            }
            forecastImagesData = imagesData
        }
    }
}


