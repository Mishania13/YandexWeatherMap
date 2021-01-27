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
            addSVGImage(iconWidth: conditionImage.bounds.width,
                        iconHeight: conditionImage.bounds.height,
                        weatherIconSVG: viewModel.weatherIcon)
                       
        }
    }
    
    func addSVGImage(iconWidth width: CGFloat, iconHeight height: CGFloat, weatherIconSVG: SVGKImage?) {
        
        if let svgImage = weatherIconSVG {
            svgImage.size = CGSize(width: width, height: height)
            let svgImageView = SVGKFastImageView(svgkImage: svgImage)
            conditionImage.addSubview(svgImageView!)
        }
    }
}
