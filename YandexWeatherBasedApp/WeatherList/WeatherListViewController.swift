//
//  WeatherListViewController.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import UIKit

//MARK:- Class

class WeatherListViewController: UIViewController {
        
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    private var viewModel: WeatherListViewModelProtocol! {
        
        didSet {
            viewModel.fetchWeatherData(clousure: {

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
    
    
}

//MARK:- TableViewDataSource

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
    @objc func handleRefreshControl(sender: UIRefreshControl) {
        self.tableView.reloadData()
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
        viewModel = WeatherListViewModel(reloadData: self.tableView.reloadData)
    }
}


