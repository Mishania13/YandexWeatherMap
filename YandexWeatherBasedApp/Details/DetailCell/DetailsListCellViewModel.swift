//
//  DetailsListCellViewModel.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 29.01.2021.
//

import Foundation

//MARK: - Protocol
protocol DetailsListCellViewModelProtocol {
    
    var currentWeekday: String {get}
    var conditionImageData: Data? {get}
    var dayTemp: String {get}
    var nightTemp: String {get}
    
    init(forecast: Forecast?, conditionImageData: Data?)
}

//MARK: - Class

class DetailsListCellViewModel: DetailsListCellViewModelProtocol {
    
    var currentWeekday: String
    var conditionImageData: Data?
    var dayTemp: String
    var nightTemp: String

    required init(forecast: Forecast?, conditionImageData: Data?) {
        let weekDays = WeekDays()
        
        currentWeekday = weekDays.getWeekday(fromDate: forecast?.date)
        
        if let temp = forecast?.parts.dayShort.temp {
            self.dayTemp = temp > 0 ? "+\(temp)" : "\(temp)"
        } else {
            self.dayTemp = "0"
        }
        
        if let temp = forecast?.parts.nightShort.temp {
            self.nightTemp = temp > 0 ? "+\(temp)" : "\(temp)"
        } else {
            self.nightTemp = "0"
        }
        
        self.conditionImageData = conditionImageData
    }
}
