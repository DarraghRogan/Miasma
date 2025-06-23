//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct TelraamDataStructure: Codable {
    var statusCode: Int?
    var message: String?
    var report: [TelraamReport]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, report
    }
}

// MARK: - Report
struct TelraamReport: Codable {
    var instanceID, segmentID: Int?
    var date: String?
    var interval: TelraamInterval?
    var uptime, heavy, car, bike: Double?
    var pedestrian, night, heavyLft, heavyRgt: Double?
    var carLft, carRgt, bikeLft, bikeRgt: Double?
    var pedestrianLft, pedestrianRgt, nightLft, nightRgt: Double?
    var direction: Int?
    var carSpeedHist0To70Plus, carSpeedHist0To120Plus: [Double]?
    var timezone: Timezone?
    var v85: Double?

    enum CodingKeys: String, CodingKey {
        case instanceID = "instance_id"
        case segmentID = "segment_id"
        case date, interval, uptime, heavy, car, bike, pedestrian, night
        case heavyLft = "heavy_lft"
        case heavyRgt = "heavy_rgt"
        case carLft = "car_lft"
        case carRgt = "car_rgt"
        case bikeLft = "bike_lft"
        case bikeRgt = "bike_rgt"
        case pedestrianLft = "pedestrian_lft"
        case pedestrianRgt = "pedestrian_rgt"
        case nightLft = "night_lft"
        case nightRgt = "night_rgt"
        case direction
        case carSpeedHist0To70Plus = "car_speed_hist_0to70plus"
        case carSpeedHist0To120Plus = "car_speed_hist_0to120plus"
        case timezone, v85
    }
}

enum TelraamInterval: String, Codable {
    case hourly = "hourly"
}

enum Timezone: String, Codable {
    case europeBrussels = "Europe/Brussels"
}


// define an instance of the data that can be filled by the data loader and read by the menu
var telraamData = TelraamDataStructure()

public class DataLoaderTelraam {
    
    
    func loadTelraamData(segmentID:String) {
        
        let headers = [
//            "Accept": "application/json",
            "X-Api-Key": "\(APIKeyTelraam)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://telraam-api.net/v1/reports/traffic")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        print(request.url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "level": "segments",
            "id": "\(segmentID)",
            "format": "per-hour",
            "time_start": "2025-05-12 11:00:00Z",
            "time_end": "2025-06-12 12:00:00Z"
        ]
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Received from the Telraam API")
                if let data = data,
                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                    print(urlContent)
                } else {
                    print("error with printing string encoded data")
                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromTelraam = try decoder.decode(TelraamDataStructure.self, from: data!)
                    telraamData = dataFromTelraam
                    
                }
                catch {
                    print("Error in Telraam JSON parsing")
                    //                    print(purpleAirData)
                }
            }
        })
        
        dataTask.resume()
    }
}
