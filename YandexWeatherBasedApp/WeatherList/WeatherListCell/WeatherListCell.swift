//
//  WeatherListCell.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import UIKit
import SVGKit

class WeatherListCell: UITableViewCell {
    
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var conditionImage: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!
    
    var viewModel: WeatherListCellViewModelProtocol! {
        didSet {
            
            cityNameLabel.text = viewModel.cityName
            temperatureLabel.text = viewModel.temp
            conditionImage.addSVGImage(weatherIconData: viewModel.weatherIconData)
        }
    }
}
