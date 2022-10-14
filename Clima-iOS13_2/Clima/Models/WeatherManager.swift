//
//  WeatherManager.swift
//  Clima
//
//  Created by juyeong koh on 2022/09/15.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL =     "https://api.openweathermap.org/data/2.5/weather?appid=11669b1d8a6c2ad880d1fc1dc7afc847&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. create a URL
        if let url = URL(string: urlString) {
            
            // 2. create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                // 에러가 나지 않을 경우 parseJSON을 코딩한다
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        // 뷰컨으로 다시 보내고싶음
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            // 4. Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

