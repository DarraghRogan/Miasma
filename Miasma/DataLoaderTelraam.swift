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
    var report: [Report]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, report
    }
}

// MARK: - Report
struct Report: Codable {
    var instanceID, segmentID: Int?
    var date: String?
    var interval: TelraamInterval?
    var uptime, heavy, car, bike: Double?
    var pedestrian: Double?
    var night: Double?
    var heavyLft, heavyRgt, carLft, carRgt: Double?
    var bikeLft, bikeRgt, pedestrianLft, pedestrianRgt: Double?
    var nightLft, nightRgt: Double?
    var direction: Int?
    var carSpeedHist0To70Plus, carSpeedHist0To120Plus: [Double]?
    var timezone: TelraamTimezone?
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

enum TelraamTimezone: String, Codable {
    case europeLondon = "Europe/London"
}


// define an instance of the data that can be filled by the data loader and read by the menu
var telraamData = TelraamDataStructure()

public class DataLoaderTelraam {
    
    
    func loadTelraamData(segmentID:String) {
        
        let headers = [
            "Accept": "application/json",
            "X-Api-Key": "\(APIKeyTelraam)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://telraam-api.net/v1/reports/traffic")! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 20.0)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        let currentDateAndTimeUnformatted = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let currentDate = dateFormatter.string(from: currentDateAndTimeUnformatted)
        
        let parameters: [String: Any] = [
            "level": "segments",
            "id": "\(segmentID)",
            "format": "per-hour",
            "time_start": "\(currentDate) 00:00:00Z",
            "time_end": "\(currentDate) 23:59:59Z"
        ]
        
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Telraam network error: \(error.localizedDescription)")
                telraamData = TelraamDataStructure(statusCode: -1, message: "Connectivity error", report: nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Telraam error: invalid response")
                telraamData = TelraamDataStructure(statusCode: -2, message: "Invalid response", report: nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Telraam HTTP error: \(httpResponse.statusCode)")
                telraamData = TelraamDataStructure(statusCode: httpResponse.statusCode, message: "HTTP error", report: nil)
                return
            }
            
            guard let data = data else {
                print("Telraam error: empty response body")
                telraamData = TelraamDataStructure(statusCode: httpResponse.statusCode, message: "Empty response", report: nil)
                return
            }
            
            print("Miasma received from the Telraam API")
            let decoder = JSONDecoder()
            do {
                let dataFromTelraam = try decoder.decode(TelraamDataStructure.self, from: data)
                telraamData = dataFromTelraam
            }
            catch {
                print("Error in Telraam JSON parsing: \(error.localizedDescription)")
                telraamData = TelraamDataStructure(statusCode: httpResponse.statusCode, message: "JSON parsing error", report: nil)
            }
        })
        
        dataTask.resume()
    }
}
