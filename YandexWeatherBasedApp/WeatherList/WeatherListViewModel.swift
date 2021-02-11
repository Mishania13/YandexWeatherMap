//
//  WeatherListViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 23.01.2021.
//

import Foundation

//MARK:- Protocol

protocol WeatherListViewModelProtocol: class {
    
    var weatherData: [YandexWeatherData?]? {get}
    var numberOfRows: Int {get}
    var reloadData: ()->Void {get}
    
    func addCity(city: String, isItCorrectCityName: @escaping(Bool) -> Void)
    func deleteCity(at indexPath: IndexPath)
    func fetchWeatherData(clousure: @escaping ()->Void)
    func showCityWeather(for city: String?, weatherData:@escaping(YandexWeatherData?)->())
    func cellViewModel(at indexPath: IndexPath) -> WeatherListCellViewModelProtocol?
}

//MARK:- Class

class WeatherListViewModel: WeatherListViewModelProtocol {
    
    
    var weatherData: [YandexWeatherData?]?
    var reloadData: () -> Void
    var numberOfRows: Int { self.weatherData?.count ?? 1 }
    
    init(reloadData: @escaping () -> Void) {
        self.reloadData = reloadData
    }
    
    func fetchWeatherData(clousure: @escaping () -> Void) {
        NetworkManager.shared.fetchWeatherForCities(for: DataManager.shared.loadData()) { (data) in
            if !data.isEmpty {
                DispatchQueue.main.async {
                    self.weatherData = data.sorted{$0.geoObject.locality.name < $1.geoObject.locality.name}
                    self.reloadData()
                }
                clousure()
            }
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> WeatherListCellViewModelProtocol? {
        WeatherListCellViewModel(weatherInfo: self.weatherData?[indexPath.row])
    }
    
    func addCity(city: String, isItCorrectCityName: @escaping(Bool) -> Void) {
        
        let locationManager = LocationManager()
        
        locationManager.getCoordinate(forCity: city) { (coordinates) in
            if let _ = coordinates {
                
                NetworkManager.shared.fetchWeatherForCities(for: [city]) { (data) in
                    
                    if let name = data.first?.geoObject.locality.name, DataManager.shared.isNewCity(city: name) {
                        DataManager.shared.addCity(city: name)
                        self.weatherData!.append(data.first)
                        self.weatherData?.sort{$0!.geoObject.locality.name<$1!.geoObject.locality.name}
                        self.reloadData()
                        isItCorrectCityName(true)
                    }
                }
            } else {
                isItCorrectCityName(false)
            }
        }
    }
    
    
    func showCityWeather(for city: String?, weatherData:@escaping(YandexWeatherData?)->()) {
        
        if let city = city, city.count >= 2 {
            
            let locationManager = LocationManager()
            locationManager.getCoordinate(forCity: city) { (coordinates) in
                if let _ = coordinates {
                    
                    NetworkManager.shared.fetchWeatherForCities(for: [city]) { (data) in
                        if data.isEmpty {
                            weatherData(nil)
                        } else {
                            weatherData(data.first)
                        }
                    }
                } else {
                    weatherData(nil)
                }
            }
        }
    }
    
    func deleteCity(at indexPath: IndexPath) {
        
        DataManager.shared.deleteCity(at: indexPath)
        self.weatherData?.remove(at: indexPath.row)
    }
}
