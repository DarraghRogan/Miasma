//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct SensorCommunityPresentDataStructureElement: Codable {
    let location: Location?
    let sensordatavalues: [Sensordatavalue]?
    let timestamp: String?
    let samplingRate: JSONNull?
    let id: Int?
    let sensor: SensorCommunitySensor?

    enum CodingKeys: String, CodingKey {
        case location, sensordatavalues, timestamp
        case samplingRate
        case id, sensor
    }
}

// MARK: - Location
struct Location: Codable {
    let indoor: Int?
    let country, latitude, altitude: String?
    let id, exactLocation: Int?
    let longitude: String?

    enum CodingKeys: String, CodingKey {
        case indoor, country, latitude, altitude, id
        case exactLocation
        case longitude
    }
}

// MARK: - Sensor
struct SensorCommunitySensor: Codable {
    let sensorType: SensorType?
    let pin: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case sensorType
        case pin, id
    }
}

// MARK: - SensorType
struct SensorType: Codable {
    let manufacturer: String?
    let id: Int?
    let name: String?
}

// MARK: - Sensordatavalue
struct Sensordatavalue: Codable {
    let valueType, value: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case valueType
        case value, id
    }
}

typealias SensorCommunityPresentDataStructure = [SensorCommunityPresentDataStructureElement]



// define an instance of the data that can be filled by the data loader and read by the menu
var sensorCommunityPresentData = SensorCommunityPresentDataStructure()

public class DataLoaderSensorCommunity {
    
    
    func loadSensorCommunityPresentData(id:String) {
        
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://data.sensor.community/airrohr/v1/sensor/\(id)/")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                                print("Miasma received from the SensorCommunity Present API")
//                                if let data = data,
//                                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                                    print(urlContent)
//                                } else {
//                                    print("error with printing string encoded data")
//                                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromSensorCommunityPresent = try decoder.decode(SensorCommunityPresentDataStructure.self, from: data!)
                    sensorCommunityPresentData = dataFromSensorCommunityPresent
                    
                }
                catch {
                    print("Error in SensorCommunity Present JSON parsing")
                }
            }
        })
        
        dataTask.resume()
    }
}
