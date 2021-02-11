//
//  WeatherListAlerts.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 06.02.2021.
//

import UIKit

extension WeatherListViewController {
  
    func addCity() {
        
        //Блокируем действия пользователя на время проверки и загрузки данных
        
        let blockingScreenView = UIView(frame: self.view.frame)
        let activityIndicator = UIActivityIndicatorView()
        blockingScreenView.backgroundColor = .lightGray
        blockingScreenView.layer.opacity = 0.6
        UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.view.addSubview(blockingScreenView)
        }, completion: nil)
        
        
        let alertTitle = "Новый город"
        let alertMessage = "Введите название города"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Город"
        }
        
        let search = UIAlertAction(title: "Поиск", style: .default) { action in
            
            let textField = alert.textFields?.first
            activityIndicator.center = blockingScreenView.center
            blockingScreenView.addSubview(activityIndicator)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                activityIndicator.startAnimating()
            }
            activityIndicator.hidesWhenStopped = true
            
            guard let cityName = textField?.text else {return}
            
            
            self.viewModel.addCity(city: cityName) {isItCorrectCityName in
                if isItCorrectCityName {
                    UIView.animate(withDuration: 0.3) {blockingScreenView.layer.opacity = 0
                    } completion: { (bool) in
                        blockingScreenView.isHidden = true
                    }
                    activityIndicator.stopAnimating()
                } else {
                    self.wrongCity()
                    UIView.animate(withDuration: 0.6) {blockingScreenView.layer.opacity = 0
                    } completion: { (bool) in
                        blockingScreenView.isHidden = true
                    }
                    activityIndicator.stopAnimating()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancle", style: .destructive) {action in
            UIView.animate(withDuration: 0.6) {blockingScreenView.layer.opacity = 0
            } completion: { (bool) in
                blockingScreenView.isHidden = true
            }
            activityIndicator.stopAnimating()
        }
        
        alert.addAction(search)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func wrongCity() {
        
        let alertTitle = "Неверное название"
        let alertMessage = "Название населенного пункта введенно неверно. Пожалуйста, попробуйте ещё раз"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func cityLimitExceeded() {
        
        let alertTitle = "Превышенно допустимое колличество городов"
        let alertMessage = "В списке не может быть больше десяти городов. Для добавление нового города удалите один из уже имеющихся"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func deleteCity(indexPath: IndexPath, clousure: @escaping (Bool)->Void) {
        
        let alertTitle = "Удаление населенного пункта"
        let alertMessage = "Вы точно хотите удалить населенный пункт из списка"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Да", style: .default) {action in
            self.viewModel.deleteCity(at: indexPath)
            clousure(true)
        }
        
        let cancel = UIAlertAction(title: "Нет", style: .default) {action in
            clousure(false)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
