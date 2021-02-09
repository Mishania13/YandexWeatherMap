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
    
    @IBOutlet private var weatherIconView: UIImageView!
    
    @IBOutlet private var detailCollectionView: UICollectionView!
    @IBOutlet private var detailTableView: UITableView!
    
    var activiIndicator = UIActivityIndicatorView()
    
    private var collectionCellIdentifire = "ColectionCellID"
    private var tableCellIdentifire = "DetailTableCellID"
    
    var weatherData: YandexWeatherData?
    
    var viewModel: DetailsViewModelProtocol! {
       
        didSet {
            
            cityNameLabel.text = viewModel.cityName
            currentTempLablel.text = viewModel.currentTemp
            feelsLikeTempLabel.text = viewModel.feelsLikeTemp
            humidityLabel.text = viewModel.humidity
            windSpeedLabel.text = viewModel.windSpeed
            pressureLabel.text = viewModel.pressure
            activiIndicator.isHidden = true
            weatherIconView.addSVGImage(weatherIconData: viewModel.weatherIconData)
            detailTableView.isHidden = false
            activiIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView()
    }
    
    func loadingView()  {
        
        detailTableView.isHidden = true
        self.view.addSubview(activiIndicator)
        activiIndicator.center = self.view.center
        activiIndicator.startAnimating()
        detailTableView.rowHeight = 50
        viewModel = DetailsViewModel(cityWeatherData: weatherData!)
    }
    
}

//MARK: - CollectionView

extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        22
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifire, for: indexPath) as! DetailsCollectionViewCell
        cell.loadVieww()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}

//MARK: - TableView

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsAtTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifire) as! DetailTableViewCell
        cell.viewModel = viewModel.detailsCellViewModel(at: indexPath)
        return cell
    }
}
