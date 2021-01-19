//
//  WeatherListCell.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//

import UIKit

class WeatherListCell: UITableViewCell {
    
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var weatherIcon: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!
    
    var viewModel: WeatherListCellViewModelProtocol! {
        didSet {
            print("KSNAKJNSJJSNJKNSJKANSANSLKN")
            cityNameLabel.text = viewModel.cityName
            temperatureLabel.text = viewModel.temp
//            if let data = viewModel.imageData {
//                weatherIcon.image = UIImage(data: data)
//            }
        }
    }
}
