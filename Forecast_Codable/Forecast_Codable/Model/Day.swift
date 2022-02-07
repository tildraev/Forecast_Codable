//
//  Day.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case days = "data"
        case cityName = "city_name"
    }
    let days: [Day]
    let cityName: String
}

struct Day: Decodable {
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case validDate = "valid_date"
        case weather = "weather"
    }
    let temp: Double
    let highTemp: Double
    let lowTemp: Double
    let validDate: String
    let weather: Weather
}
    
struct Weather: Decodable {
    private enum CodingKeys: String, CodingKey {
        case description = "description"
        case iconString = "icon"
    
    }
    let description: String
    let iconString: String
    
}
