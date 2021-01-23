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
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    private let refreshControl = UIRefreshControl()
    var activiIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 50
        viewLoading()
    }
    
    func getCitiesWeather() {
       
        var count = 1
        for city in cities {
            NetworkManager.shared.fetchData(forCity: city) {[unowned self] (data) in
                self.weatherData?.append(data)
                if count == cities.count {
                self.tableView.reloadData()
                    print("Finished")
                    self.activiIndicator.isHidden = true
                    self.tableView.isHidden = false
                    self.activiIndicator.stopAnimating()
                }
                count += 1
            }
        }
    }
}

//MARK:- TableViewDataSource

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCellIdentifire", for: indexPath) as! WeatherListCell
        if let data = weatherData {
        cell.viewModel = WeatherListCellViewModel(weatherInfo: data[indexPath.row])
        }
        return cell
    }
    @objc func handleRefreshControl(sender: UIRefreshControl) {
        
//        self.viewModel = CurrencyListViewModel(reloadData: self.tableView.reloadData)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func viewLoading() {
        
        self.refreshControl.addTarget(self, action: #selector(handleRefreshControl(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        self.tableView.refreshControl = refreshControl
        self.tableView.isHidden = true
        self.view.addSubview(activiIndicator)
        activiIndicator.center = self.view.center
        activiIndicator.startAnimating()
        tableView.rowHeight = 50
        getCitiesWeather()
    }
}


