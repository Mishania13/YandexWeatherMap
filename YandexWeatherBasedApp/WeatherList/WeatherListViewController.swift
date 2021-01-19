//
//  WeatherListViewController.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import UIKit

//MARK:- Class

class WeatherListViewController: UIViewController {
    
    var weatherData: [YandexWeatherData]?
    
    @IBOutlet private var table: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.rowHeight = 50
        self.getCitiesWeather()
        self.table.reloadData()
    }
    
    func getCitiesWeather() {
        for city in cities {
            NetworkManager.shared.fetchData(forCity: city) {[unowned self] (data) in
                self.weatherData?.append(data)
                print(data)
                self.table.reloadData()
            }
        }
    }
}

//MARK:- TableViewDataSource

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCellIdentifire", for: indexPath) as! WeatherListCell
//        if let weatherData = self.weatherData {
//            cell.viewModel = WeatherListCellViewModel(weatherInfo: weatherData[indexPath.row])
//        }
//        let data = try? Data(contentsOf: URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/ovc.svg")!)
//        cell.weatherIcon.image = UIImage(data: data!)
        return cell
    } 
}


