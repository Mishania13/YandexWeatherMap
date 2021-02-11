//
//  WeatherListViewController.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import UIKit
import SVGKit

class WeatherListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var addCityButton: UIButton!
    
    private let textFieldPlacholderText = "Введите название города"
    private let segueID = "goToDetails"
    
    var clearButton: UIButton!
    
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
        viewModel.numberOfRows <= 10 ? addCity() : cityLimitExceeded()
    }
    
    @IBAction func textFieldEndEdditing() {
        
        viewModel.showCityWeather(for: self.textField.text) { (data) in
            DispatchQueue.main.async {
                if let data = data {
                    self.performSegue(withIdentifier: self.segueID, sender: data)
                } else {
                    self.wrongCity()
                }
            }
            self.textField.text = nil
        }
    }
    
    private func viewLoading() {
        
        refreshControl.addTarget(self, action: #selector(handleRefreshControl(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        
        tableView.refreshControl = refreshControl
        tableView.isHidden = true
        tableView.rowHeight = 50
        
        addCityButton.isHidden = true
        
        view.addSubview(activiIndicator)
        activiIndicator.center = self.view.center
        activiIndicator.startAnimating()
        
        textFieldPreparation()
        
        viewModel = WeatherListViewModel(reloadData: self.tableView.reloadData)
    }
    
    func textFieldPreparation() {
        
        //Делаем отображение текста плейсхолдера по центру
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: textFieldPlacholderText, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        textField.textAlignment = .center
        //Увеличиваем скругление рамки
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        textField.layer.cornerRadius = textField.bounds.height/2
        textField.layer.masksToBounds = true
        
        //Добавляем изображение справа
        textField.rightViewMode = UITextField.ViewMode.unlessEditing
        textField.setRightImageView(image: UIImage(systemName: "magnifyingglass")!, color: UIColor.lightGray.withAlphaComponent(0.5), padding: 20)
        //Добавлемем пустое изображение слева чтоб выравнять плейсхолдер
        textField.leftViewMode = UITextField.ViewMode.unlessEditing
        textField.setLeftImageView(image: UIImage(), color: UIColor(), padding: 40)
        textField.clearButtonMode = .whileEditing
        
        //Скрытие клавиатуры
        let tap = UITapGestureRecognizer(target: view, action: #selector(textField.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        textField.autocorrectionType = .no
        textField.delegate = self
    }
    
    @objc func handleRefreshControl(sender: UIRefreshControl) {
        viewModel = WeatherListViewModel(reloadData: self.tableView.reloadData)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        }
    }
}

//MARK: - TextField

extension WeatherListViewController: UITextFieldDelegate  {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldEndEdditing()
        textField.resignFirstResponder()
        return true
    }
}
