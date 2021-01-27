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
    
    func fetchWeatherData(clousure: @escaping ()->Void)
    func cellViewModel(at indexPath: IndexPath) -> WeatherListCellViewModelProtocol?
}

//MARK:- Class

class WeatherListViewModel: WeatherListViewModelProtocol {
    
    var weatherData: [YandexWeatherData?]?
    var reloadData: () -> Void
    var numberOfRows: Int {
        get {
            return self.weatherData?.count ?? 1
        }
    }
    
    func fetchWeatherData(clousure: @escaping () -> Void) {
        NetworkManager.shared.fetchWeatherForCities { (data) in
            DispatchQueue.main.async {
                self.weatherData = data
                self.reloadData()
                clousure()
            }
        }
    }

    func cellViewModel(at indexPath: IndexPath) -> WeatherListCellViewModelProtocol? {
        WeatherListCellViewModel(weatherInfo: self.weatherData?[indexPath.row])
    }
    
    init(reloadData: @escaping () -> Void) {
        self.reloadData = reloadData
    }
}
