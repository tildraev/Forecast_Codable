//
//  NetworkController.swift
//  Forecast_Codable
//
//  Created by Arian Mohajer on 2/7/22.
//

import Foundation

class NetworkController {
    
    private static let baseURLString = "https://api.weatherbit.io"
    
    static func fetchDays(completion: @escaping (TopLevelDictionary?) -> Void ) {
        guard let baseURL = URL(string: baseURLString) else {
            print("Could not make url from baseURLString: \(baseURLString)")
            completion(nil)
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.path = "/v2.0/forecast/daily/"
        
        let unitsQuery = URLQueryItem(name: "units", value: "I")
        let locationQuery = URLQueryItem(name: "city", value: "SaltLakeCity")
        let apiQuery = URLQueryItem(name: "key", value: "cab12b2293ff4dbe83068be7f0ded509")
        
        urlComponents?.queryItems = [unitsQuery, locationQuery, apiQuery]
        
        guard let finalURL = urlComponents?.url else {
            print("Error making finalURL from urlCompoments: \(String(describing: urlComponents))")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Error starting dataTask from finalURL: \(finalURL)", error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error retrieving data. \(data)")
                completion(nil)
                return
            }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(topLevelDictionary)
            } catch {
                print("Error in do/try/catch: ", error)
                completion(nil)
            }

        }.resume()
        
    }
}
