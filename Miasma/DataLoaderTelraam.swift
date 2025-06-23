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
    var message, type: String?
    var features: [Feature]?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, type, features
    }
}

// MARK: - Feature
struct Feature: Codable {
    var type: String?
    //    var geometry: Geometry?
    var properties: Properties?
}

// MARK: - Geometry
//struct Geometry: Codable {
//    var type: String?
//    var coordinates: [[[Double]]]?
//}

// MARK: - Properties
struct Properties: Codable {
    var oidn: Int?
    var firstDataPackage, lastDataPackage: String?
    //    var speed: Int?
    //    var oneway: Bool?
    //    var roadType, roadSpeed: String?
    var pedestrian, bike, car, lorry: Double?
    //    var speedHistogram: [Double]?
    //    var speedBuckets: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case oidn
        case firstDataPackage = "first_data_package"
        case lastDataPackage = "last_data_package"
        //        case speed, oneway
        //        case roadType = "road_type"
        //        case roadSpeed = "road_speed"
        case pedestrian, bike, car, lorry
        //        case speedHistogram = "speed_histogram"
        //        case speedBuckets = "speed_buckets"
    }
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
