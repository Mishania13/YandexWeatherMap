//
//  CollectionViewCell.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 27.01.2021.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    func loadVieww() {
        hourLabel.text = "11"
        weatherImageView.image = UIImage(systemName: "cloud")
        temperatureLabel.text = "22"
    }
}
