//
//  DataManager.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 06.02.2021.
//

import Foundation

struct DataManager {
    
    static var shared = DataManager()
    
    private let userDefault = UserDefaults.standard
    
    private let citiesKey = "City"
    private let firstRunCities = ["Москва"]
    
    private mutating func saveData(cities: [String]) {
        userDefault.set(cities, forKey: citiesKey)
    }
    
    mutating func loadData() -> [String] {
        //проверяем запускалось ли приложение ранее
        if let savedCities = userDefault.object(forKey: citiesKey) as? [String] {
            return savedCities.sorted{$0<$1}
        } else {
            saveData(cities: firstRunCities.sorted{$0<$1})
            return firstRunCities
        }
    }
    
    mutating func addCity(city: String) {
        
        var cities = loadData()
        cities.append(city)
        saveData(cities: cities.sorted{$0<$1})
    }
    
    mutating func deleteCity(at indexPath: IndexPath) {
        
        var cities = loadData().sorted{$0<$1}
        cities.remove(at: indexPath.row)
        saveData(cities: cities)
    }
    
    mutating func isNewCity(city: String) -> Bool {
        !loadData().contains(city)
    }
}
