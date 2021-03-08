//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io


struct ClimaCellDataStructure: Codable {
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var timelines: [Timeline]?
}

// MARK: - Timeline
struct Timeline: Codable {
//    var timestep: String?
//    var startTime, endTime: Date?
    var intervals: [Interval]?
}

// MARK: - Interval
struct Interval: Codable {
//    var startTime: Date?
    var values: Values?
}

// MARK: - Values
struct Values: Codable {
    var treeIndex, grassIndex, weedIndex: Double?
    var temperatureApparent: Double?
    var weatherCode: Int?
    var windDirection, windSpeed: Double?
    var epaIndex, epaPrimaryPollutant: Int?
}


//    typealias ClimaCellDataStructure = [WelcomeElement]


// define an instance of the data that can be filled by the data loader and read by the menu
var climaCellData = ClimaCellDataStructure()

public class DataLoaderClimaCell {
    
    
    func loadClimaCellData(lat:Double, lon:Double) {
        
        
        let headers = [
            "Accept": "application/json"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string:
            "https://data.climacell.co/v4/timelines?location=\(lat),\(lon)&fields=treeIndex,grassIndex,weedIndex,temperatureApparent,weatherCode,windDirection,windSpeed,epaIndex,epaPrimaryPollutant&apikey=\(APIKeyClimaCellV4)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        print(request)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Received from the ClimaCell API")
                if let data = data,
                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                    print(urlContent)
                } else {
                    print("error with printing string encoded data")
                }
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
