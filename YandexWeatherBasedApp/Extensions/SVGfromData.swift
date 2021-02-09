//
//  SVGfromData.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 04.02.2021.
//

import SVGKit
import UIKit

extension UIImageView {
  
    func addSVGImage(weatherIconData: Data?) {
        if let _ = weatherIconData, let svgImage = SVGKImage(data: weatherIconData!) {
            svgImage.size = CGSize(width: self.bounds.width, height: self.bounds.height)
            let svgImageView = SVGKFastImageView(svgkImage: svgImage)
            self.addSubview(svgImageView!)
        }
    }
}
