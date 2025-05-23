//
//  WeatherData.swift
//  Clima
//
//  Created by Paweł Łąk on 21/05/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e72ca729af228beabd5d20e3b7749713&units=metric"
    
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
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url,completionHandler: handle)
           
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?)
    {
        if error != nil {
            self.delegate?.didFailWithError(error: error!)
            return
        }
        
        if let safeData = data {
            if let weather = self.parseJSON(safeData) {
                 self.delegate?.didUpdateWeather(self, weather: weather)
            }
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
          do {
           //just because openweathermap return 401 error... replace weatherData with mock data

            let JSON = """
            {
                "name": "\(getRandomLocation())",
                "temp":  \(getRandomTemperature()),
                "weather": "light rain",
                "weatherId": \(getRandomWeather())
            }
            """
                        
            let jsonData = JSON.data(using: .utf8)!
            let decodedData: WeatherData = try JSONDecoder().decode(WeatherData.self, from: jsonData)
              let weather = WeatherModel(conditionId: decodedData.weatherId, cityName: decodedData.name, temperature: decodedData.temp)
            return weather
            
        } catch {

            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    private func getRandomWeather() -> Int {
        return Int.random(in: 200...500)
    }
    
    private func getRandomLocation() -> String {
        return "Location_\(Int.random(in: 1...1000))"
    }
    
    private func getRandomTemperature() -> Double {
        return Double.random(in: 0...20)
    }
}
