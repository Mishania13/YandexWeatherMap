//
//  WeatherListConfigurator.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import Foundation

//MARK:- Protocol

protocol WeatherListConfiguratorInputProtocol {
    func configure(with viewController: WeatherListViewController)
}

//MARK:- Class

class WeatherListConfigurator: WeatherListConfiguratorInputProtocol {
    
    func configure(with viewController: WeatherListViewController) {
        let presenter = WeatherListPresenter(view: viewController)
        let interactor = WeatherListInteractor(presenter: presenter)
        let router = WeatherListRouter(viewController: viewController)
            
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
