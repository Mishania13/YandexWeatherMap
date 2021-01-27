//
//  DetailsViewController.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 24.01.2021.
//

import UIKit
import SVGKit

class DetailsViewController: UIViewController {

    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var currentTempLablel: UILabel!
    @IBOutlet private var feelsLikeTempLabel: UILabel!
    @IBOutlet private var humidityLabel: UILabel!
    @IBOutlet private var windSpeedLabel: UILabel!
    @IBOutlet private var pressureLabel: UILabel!
    
    @IBOutlet private var weatherIconView: UIView!
    
    @IBOutlet private var detailCollectionView: UICollectionView!
    @IBOutlet private var detailTableView: UITableView!
    
    var weatherSVGImage: SVGKImage?
    
    var viewModel: DetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView()
    }
    
    func loadingView()  {
        
        collectionViewLoading()
        
        cityNameLabel.text = viewModel.cityName
        currentTempLablel.text = (viewModel.currentTemp)
        feelsLikeTempLabel.text = viewModel.feelsLikeTemp
        humidityLabel.text = viewModel.humidity
        windSpeedLabel.text = viewModel.windSpeed
        pressureLabel.text = viewModel.pressure
    }
    
    func collectionViewLoading() {
        if let layout = detailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

//MARK: - CollectionView


