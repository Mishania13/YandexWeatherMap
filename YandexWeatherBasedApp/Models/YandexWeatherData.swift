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
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case fact
        case forecasts
    }
}

// MARK: - Fact
struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let icon: Icon
    let condition: Condition
    let windSpeed: Int
    let windDir: WindDir
    let pressureMm:Int
    let humidity: Int
    let daytime: Daytime
    let season: String

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

enum Condition: String, Codable {
    
    case clear = "clear"
    case cloudy = "cloudy"
    case lightSnow = "light-snow"
    case overcast = "overcast"
    case snow = "snow"
}

enum Daytime: String, Codable {
    
    case d = "d"
    case n = "n"
}

enum Icon: String, Codable {
    
    case bknD = "bkn_d"
    case bknN = "bkn_n"
    case bknSnD = "bkn_-sn_d"
    case bknSnN = "bkn_-sn_n"
    case iconOvcSn = "ovc_sn"
    case ovc = "ovc"
    case ovcSn = "ovc_-sn"
    case skcN = "skc_n"
}

enum WindDir: String, Codable {
    
    case e = "e"
    case n = "n"
    case ne = "ne"
    case nw = "nw"
    case s = "s"
    case se = "se"
    case sw = "sw"
    case w = "w"
}

// MARK: - Forecast
struct Forecast: Codable {
    
    let date: String
    let parts: Parts
    let hours: [Hour]
}

// MARK: - Hour
struct Hour: Codable {
    
    let hour: String?
    let temp: Int?
    let icon: Icon
}

// MARK: - Parts
struct Parts: Codable {
    let night, day, evening, morning, nightShort, dayShort: Hour

    enum CodingKeys: String, CodingKey {
        
        case night, day, evening, morning
        case nightShort = "night_short"
        case dayShort = "day_short"
    }
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let district, locality: Country
}

// MARK: - Country
struct Country: Codable {
    
    let id: Int
    let name: String
}

