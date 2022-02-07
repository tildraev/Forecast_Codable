//
//  Day.swift
//  Forecast_Codable
//
//  Created by Arian Mohajer on 2/7/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case days = "data"
    }
    
    let cityName: String
    let days: [Day]
}

struct Day: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case validDate = "valid_date"
        case weather
    }
    
    let currentTemp: Double
    let highTemp: Double
    let lowTemp: Double
    let validDate: String
    let weather: Weather
}

struct Weather: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case description
        case iconString = "icon"
    }
    
    let description: String
    let iconString: String
}
