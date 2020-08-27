//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io


struct PurpleAirDataStructure: Codable {
//    var mapVersion, baseVersion, mapVersionString: String?
    var results: [PurpleAirResult]?
}

struct PurpleAirResult: Codable {
    var id: Int
    var label: String
    var deviceLocationtype: String?
//    var thingspeakPrimaryID, thingspeakPrimaryIDReadKey, thingspeakSecondaryID, thingspeakSecondaryIDReadKey: String
//    var lat, lon: Double
    var pm25Value: String?
//    var lastSeen: Int
//    var type: String?
//    var hidden: String
//    var deviceBrightness, deviceHardwarediscovered, deviceFirmwareversion, version: String?
//    var lastUpdateCheck: Int?
//    var created: Int
//    var uptime, rssi, adc: String?
//    var p0_3_Um, p0_5_Um, p1_0_Um, p2_5_Um: String
//    var p5_0_Um, p10_0_Um, pm10_CF1, pm25_CF1: String
//    var pm100_CF1, pm10_ATM, pm25_ATM, pm100_ATM: String
//    var isOwner: Int
    var humidity, tempF, pressure: String?
    var age: Int
//    var stats: String
//    var parentID: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case label = "Label"
        case deviceLocationtype = "DEVICE_LOCATIONTYPE"
//        case thingspeakPrimaryID = "THINGSPEAK_PRIMARY_ID"
//        case thingspeakPrimaryIDReadKey = "THINGSPEAK_PRIMARY_ID_READ_KEY"
//        case thingspeakSecondaryID = "THINGSPEAK_SECONDARY_ID"
//        case thingspeakSecondaryIDReadKey = "THINGSPEAK_SECONDARY_ID_READ_KEY"
//        case lat = "Lat"
//        case lon = "Lon"
        case pm25Value = "PM2_5Value"
//        case lastSeen = "LastSeen"
//        case type = "Type"
//        case hidden = "Hidden"
//        case deviceBrightness = "DEVICE_BRIGHTNESS"
//        case deviceHardwarediscovered = "DEVICE_HARDWAREDISCOVERED"
//        case deviceFirmwareversion = "DEVICE_FIRMWAREVERSION"
//        case version = "Version"
//        case lastUpdateCheck = "LastUpdateCheck"
//        case created = "Created"
//        case uptime = "Uptime"
//        case rssi = "RSSI"
//        case adc = "Adc"
//        case p0_3_Um = "p_0_3_um"
//        case p0_5_Um = "p_0_5_um"
//        case p1_0_Um = "p_1_0_um"
//        case p2_5_Um = "p_2_5_um"
//        case p5_0_Um = "p_5_0_um"
//        case p10_0_Um = "p_10_0_um"
//        case pm10_CF1 = "pm1_0_cf_1"
//        case pm25_CF1 = "pm2_5_cf_1"
//        case pm100_CF1 = "pm10_0_cf_1"
//        case pm10_ATM = "pm1_0_atm"
//        case pm25_ATM = "pm2_5_atm"
//        case pm100_ATM = "pm10_0_atm"
//        case isOwner
        case humidity
        case tempF = "temp_f"
        case pressure
        case age = "AGE"
//        case stats = "Stats"
//        case parentID = "ParentID"
    }
}




// define an instance of the data that can be filled by the data loader and read by the menu
var purpleAirData = PurpleAirDataStructure()

 public class DataLoaderPurpleAir {

    
    func loadPurpleAirData(id:Int) {

        
        let headers = [
            "Accept": "application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string:
         "https://www.purpleair.com/json?key=\(APIKeyPurpleAir)&show=\(AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String())")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
//                print("Received from the Purple Air API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromPurpleAir = try decoder.decode(PurpleAirDataStructure.self, from: data!)
                    purpleAirData = dataFromPurpleAir
//                    print(purpleAirData.results?[0].deviceLocationtype)

                }
                catch {
                    print("Error in Purple Air JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
