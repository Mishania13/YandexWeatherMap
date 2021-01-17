//
//  WeatherListRouter.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import Foundation

//MARK:- Protocols

protocol WeatherListRouterInputProtocol {
    init(viewController: WeatherListViewController)
    func openDetailsViewController(with city: String)
}

//MARK:- Class

class WeatherListRouter: WeatherListRouterInputProtocol {
 
    unowned let viewController: WeatherListViewController
    
    required init(viewController: WeatherListViewController) {
        self.viewController = viewController
    }
    
    func openDetailsViewController(with city: String) {
        viewController.performSegue(withIdentifier: "", sender: city)
    }
}
