//
//  DetailTableViewCell.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 27.01.2021.
//

import UIKit
import SVGKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet  var weekDayLabel: UILabel!
    @IBOutlet  var dayTempLabel: UILabel!
    @IBOutlet  var nightTempLabel: UILabel!
    @IBOutlet  var conditionImageView: UIImageView!
    private var activiIndicator = UIActivityIndicatorView()

    var viewModel: DetailsListCellViewModelProtocol? {
        didSet {
            
            weekDayLabel.text = viewModel?.currentWeekday
            dayTempLabel.text = viewModel?.dayTemp
            nightTempLabel.text = viewModel?.nightTemp
//            if let _ = viewModel.conditionImageData {
//                conditionImageView.addSVGImage(weatherIconData: viewModel.conditionImageData)
//                activiIndicator.stopAnimating()
//            } else {
//                self.conditionImageView.addSubview(activiIndicator)
//                activiIndicator.center = self.conditionImageView.center
//                activiIndicator.startAnimating()
//                activiIndicator.hidesWhenStopped = true
//            }
        }
    }
}
