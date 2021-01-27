//
//  YandexWeatherData.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 17.01.2021.
//
import Foundation

struct YandexWeatherData: Codable {

    let geoObject: GeoObject
    let fact: Fact
//    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case fact
//        case forecasts
    }
}

// MARK: - Fact
struct Fact: Codable {
    
    let temp: Int?
    let feelsLike: Int?
    let icon: String?
    let condition: String?
    let windSpeed: Double?
    let windDir: String?
    let pressureMm: Int?
    let humidity: Int?
    let daytime: String?
    let season: String?

    enum CodingKeys: String, CodingKey {

        case temp
        case feelsLike = "feels_like"
        case icon
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case humidity
        case daytime
        case season
    }
}

// MARK: - Forecast
struct Forecast: Codable {

    let date: String?
    let hours: [Hour]
}

// MARK: - Hour
struct Hour: Codable {

    let hour: String?
    let temp: Int?
    let icon: String?
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let district, locality: Country
}

// MARK: - Country
struct Country: Codable {

    let name: String?
}

