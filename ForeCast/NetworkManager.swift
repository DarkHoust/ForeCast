//
//  NetworkManager.swift
//  ForeCast
//
//  Created by Sultan on 04.08.2024.
//

import Foundation
import Alamofire

@Observable
class NetworkManager {
    static let shared = NetworkManager()
    
    private let apiKey = "1a28b33a891892fb344561ec345d78e5"
    private let baseURL = "http://api.openweathermap.org/data/2.5/forecast"
    
    var forecasts: [List] = []
    
    func getWeatherInfo() {
        let parameters = [
            "lat": "51.1282205",
            "lon": "71.4306682",
            "cnt": "7",
            "appid": apiKey
        ]
        
        AF.request(baseURL, parameters: parameters).responseDecodable(of: Weather.self) { response in
            if let result = try? response.result.get() {
                DispatchQueue.main.async {
                    self.forecasts = result.list
                }
            }
        }
    }
}
