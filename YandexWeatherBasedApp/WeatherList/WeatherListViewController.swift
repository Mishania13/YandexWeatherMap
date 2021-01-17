//
//  WeatherListViewController.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import UIKit
//MARK:- Protocols
protocol WeatherListViewInputProtocol: class {

}

protocol WeatherListViewOutputProtocol: class {
    init(view: WeatherListViewInputProtocol)
    func showDetails()
}

//MARK:- Class

class WeatherListViewController: UIViewController {

    @IBOutlet private var table: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    var presenter: WeatherListViewOutputProtocol!
    private let configurator: WeatherListConfiguratorInputProtocol = WeatherListConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK:- TableViewDataSource

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainViewCell", for: indexPath) as! WeatherListCell
                
        return cell
    }
    
    
}

//MARK:- ViewInputProtocol

extension WeatherListViewController: WeatherListViewInputProtocol {
    
}
