//
//  WeatherListViewController.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import UIKit
import SVGKit

class WeatherListViewController: UIViewController {
        
    @IBOutlet  var tableView: UITableView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var addCityButton: UIButton!
    
    private let segueID = "goToDetails"
    
    var viewModel: WeatherListViewModelProtocol! {
        
        didSet {
            viewModel.fetchWeatherData(clousure: { 
                
                self.activiIndicator.isHidden = true
                self.tableView.isHidden = false
                self.addCityButton.isHidden = false
                self.activiIndicator.stopAnimating()
            })
        }
    }
    
    private let refreshControl = UIRefreshControl()
    private var activiIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 50
        viewLoading()
    }
    
    @IBAction private func addCityButtonPressed() {
        addCity()
    }
    
    private func viewLoading() {
        
        refreshControl.addTarget(self, action: #selector(handleRefreshControl(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        tableView.refreshControl = refreshControl
        tableView.isHidden = true
        addCityButton.isHidden = true
        view.addSubview(activiIndicator)
        activiIndicator.center = self.view.center
        activiIndicator.startAnimating()
        tableView.rowHeight = 50
        textField.placeholder = ""
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
            detailVC.weatherData = currentWeather
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteCity(indexPath: indexPath) { (needToDelete) in
                if needToDelete {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            print("DELETE")
        }
    }
}
extension WeatherListViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
