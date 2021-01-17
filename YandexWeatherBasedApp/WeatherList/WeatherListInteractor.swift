//
//  WeatherListInteractor.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import Foundation

//MARK:- Protocols

protocol WeatherListInteractorInputProtocol: class {
    init(presenter: WeatherListInteractorOutputProtocol)
    func fetchCitiesWeather()
}

protocol WeatherListInteractorOutputProtocol: class {

}

//MARK:- Class

class WeatherListInteractor: WeatherListInteractorInputProtocol {
   
    unowned let presenter: WeatherListInteractorOutputProtocol
    
    required init(presenter: WeatherListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchCitiesWeather() {
        <#code#>
    }
}
