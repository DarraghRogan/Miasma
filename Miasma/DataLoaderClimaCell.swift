//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io


struct WelcomeElement: Codable {
        var lat, lon: Double?
        var temp: FeelsLike?
        var feelsLike: FeelsLike?
        var windSpeed: FeelsLike?
        var windDirection: FeelsLike?
        var epaAqi: EpaAqi?
        var epaPrimaryPollutant: EpaPrimaryPollutant?
//        var pm25: FeelsLike?
        var pollenTree, pollenWeed, pollenGrass: FeelsLike?
        var observationTime: EpaPrimaryPollutant?
        var weatherCode: EpaPrimaryPollutant?

        enum CodingKeys: String, CodingKey {
            case lat, lon
            case temp
            case feelsLike = "feels_like"
            case windSpeed = "wind_speed"
            case windDirection = "wind_direction"
            case epaAqi = "epa_aqi"
            case epaPrimaryPollutant = "epa_primary_pollutant"
//            case pm25
            case pollenTree = "pollen_tree"
            case pollenWeed = "pollen_weed"
            case pollenGrass = "pollen_grass"
            case observationTime = "observation_time"
            case weatherCode = "weather_code"
        }
    }

    struct EpaAqi: Codable {
        var value: Double?
    }

    struct EpaPrimaryPollutant: Codable {
        var value: String?
    }

    struct FeelsLike: Codable {
        var value: Double?
        var units: Units?
    }

    enum Units: String, Codable {
        case c = "C"
        case climacellPollenIndex = "Climacell Pollen Index"
        case degrees = "degrees"
        case mS = "m/s"
        case âµgM3 = "Âµg/m3"
    }

    typealias ClimaCellDataStructure = [WelcomeElement]


// define an instance of the data that can be filled by the data loader and read by the menu
var climaCellData = ClimaCellDataStructure()

public class DataLoaderClimaCell {
    
    
    func loadClimaCellData(lat:Double, lon:Double) {
        
        
        let headers = [
            "Accept": "application/json"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string:
            "https://api.climacell.co/v3/weather/nowcast?lat=\(lat)&lon=\(lon)&unit_system=si&timestep=60&start_time=now&fields=pollen_tree%2Cpollen_grass%2Cpollen_weed%2Cfeels_like%2Ctemp%2Cweather_code%2Cwind_direction%2Cwind_speed%2Cpm25%2Cepa_aqi%2Cepa_primary_pollutant&apikey=\(APIKeyClimaCell)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
//        print(request)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
//                print("Received from the ClimaCell API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromClimaCell = try decoder.decode(ClimaCellDataStructure.self, from: data!)
                    climaCellData = dataFromClimaCell
                }
                catch {
                    print("Error in ClimaCell JSON parsing")
                }
                
            }
        })
        
        dataTask.resume()
    }
}
