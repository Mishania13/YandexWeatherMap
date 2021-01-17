//
//  WeatherListPresenter.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import Foundation

class WeatherListPresenter: WeatherListViewOutputProtocol {
   
    func showDetails() {
        print("SHOW")
    }
    
    unowned let view: WeatherListViewInputProtocol
    var interactor: WeatherListInteractorInputProtocol!
    var router: WeatherListRouterInputProtocol!

    
    required init(view: WeatherListViewInputProtocol) {
        self.view = view
    }
}

extension WeatherListPresenter: WeatherListInteractorOutputProtocol {

}
