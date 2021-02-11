//
//  TextFieldRightViewPadding.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 09.02.2021.
//

import UIKit

extension UITextField {
    
    func setRightImageView(image: UIImage, color: UIColor, padding: CGFloat) {
            
        let view = UIImageView(image: image)
        view.tintColor = color
        view.translatesAutoresizingMaskIntoConstraints = true

            let outerView = UIView()
            outerView.translatesAutoresizingMaskIntoConstraints = false
            outerView.addSubview(view)

            outerView.frame = CGRect(
                origin: .zero,
                size: CGSize(
                    width: view.frame.size.width + padding,
                    height: view.frame.size.height + padding
                )
            )

            view.center = CGPoint(
                x: outerView.bounds.size.width / 2,
                y: outerView.bounds.size.height / 2
            )

            rightView = outerView
        }
   
    func setLeftImageView(image: UIImage, color: UIColor, padding: CGFloat) {
            
        let view = UIImageView(image: image)
        view.tintColor = color
        view.translatesAutoresizingMaskIntoConstraints = true

            let outerView = UIView()
            outerView.translatesAutoresizingMaskIntoConstraints = false
            outerView.addSubview(view)

            outerView.frame = CGRect(
                origin: .zero,
                size: CGSize(
                    width: view.frame.size.width + padding,
                    height: view.frame.size.height + padding
                )
            )

            view.center = CGPoint(
                x: outerView.bounds.size.width / 2,
                y: outerView.bounds.size.height / 2
            )

            leftView = outerView
        }
}
