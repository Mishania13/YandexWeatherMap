//
//  WeatherListViewController.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import UIKit
import SVGKit

class WeatherListViewController: UIViewController {
        
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    private let segueID = "goToDetails"
    
    private var viewModel: WeatherListViewModelProtocol! {
        
        didSet {
            viewModel.fetchWeatherData(clousure: { [self] in

                self.activiIndicator.isHidden = true
                self.tableView.isHidden = false
                self.activiIndicator.stopAnimating()
            })
        }
    }
    
    private let refreshControl = UIRefreshControl()
    var activiIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 50
        viewLoading()
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
        viewModel = WeatherListViewModel(reloadData: self.tableView.reloadData)
    }
    
    @objc func handleRefreshControl(sender: UIRefreshControl) {
        viewModel = WeatherListViewModel(reloadData: self.tableView.reloadData)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}
//MARK: - Navigation

extension WeatherListViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueID,
            let detailVC = segue.destination as? DetailsViewController,
            let currentWeather = sender as? YandexWeatherData {
            detailVC.viewModel = DetailsViewModel(cityWeatherData: currentWeather)
            }
        }
}
//MARK: - TableViewDataSource

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCellIdentifire", for: indexPath) as! WeatherListCell
       let cellViewModel = self.viewModel.cellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

//MARK: - TableViewDelegate

extension WeatherListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: segueID, sender: viewModel.weatherData![indexPath.row])
    }
}







