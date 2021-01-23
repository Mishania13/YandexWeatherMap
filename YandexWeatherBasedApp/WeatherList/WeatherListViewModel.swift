//
//  WeatherListViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 23.01.2021.
//

import Foundation

protocol WeatherListViewModelProtocol: class {
    
    var weatherData: [YandexWeatherData]? {get}
    
    var reloadData: ()->Void {get}
    
    func fetchWeatherData(clousure: @escaping ()->Void)
    func cellViewModel(at indexPath: IndexPath) -> WeatherListCellViewModelProtocol?
}

class WeatherListViewModel: WeatherListCellViewModelProtocol {
    
}
