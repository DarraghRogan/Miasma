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
    //    var apiVersion: String?
    //    var timeStamp: Int?
    var sensor: Sensor?
    
    enum CodingKeys: String, CodingKey {
        //        case apiVersion = "api_version"
        //        case timeStamp = "time_stamp"
        case sensor
    }
}

struct Sensor: Codable {
    var sensorIndex: Int?
    var name: String?
    //    var model: String?
    //    var locationType: Int?
    var latitude, longitude: Double?
    //    var altitude: Int?
    var lastSeen: Int?
    //    var lastModified, sensorPrivate: Int?
    //    var channelState, channelFlagsManual,
    var humidity, temperature: Int?
    var pressure: Double?
    //    var pm10_A, pm10_B: Double?
    var pm25_A: Double?
    var pm25_B: Double?
    var pm25_cf_1: Double?
    //    var pm100_A, pm100_B: Double?
    //    var the03_UmCountA: Int?
    //    var the03_UmCountB, the05_UmCountA, the05_UmCountB, the10_UmCountA: Double?
    //    var the10_UmCountB, the25_UmCountA, the25_UmCountB, the50_UmCountA: Double?
    //    var the50_UmCountB, the100_UmCountA, the100_UmCountB: Double?
    //    var statsA, statsB: [String: Double]?
    //    var analogInput: Double?
    //    var primaryIDA: Int?
    //    var primaryKeyA: String?
    //    var secondaryIDA: Int?
    //    var secondaryKeyA: String?
    //    var primaryIDB: Int?
    //    var primaryKeyB: String?
    //    var secondaryIDB: Int?
    //    var secondaryKeyB, hardware: String?
    //    var ledBrightness: Int?
    //    var firmwareUpgrade, firmwareVersion: String?
    //    var rssi, icon, confidenceManual, confidenceAuto: Int?
    //    var channelFlagsAuto: Int?
    var stats: Stats?
    
    enum CodingKeys: String, CodingKey {
        case sensorIndex = "sensor_index"
        case name
        //        case model
        //        case locationType = "location_type"
        case latitude, longitude
        //        case altitude
        case lastSeen = "last_seen"
        //        case lastModified = "last_modified"
        //        case sensorPrivate = "private"
        //        case channelState = "channel_state"
        //        case channelFlagsManual = "channel_flags_manual"
        case humidity = "humidity"
        case temperature = "temperature"
        case pressure = "pressure"
        //        case pm10_A = "pm1.0_a"
        //        case pm10_B = "pm1.0_b"
        case pm25_A = "pm2.5_a"
        case pm25_B = "pm2.5_b"
        case pm25_cf_1 = "pm2.5_cf_1"
        //        case pm100_A = "pm10.0_a"
        //        case pm100_B = "pm10.0_b"
        //        case the03_UmCountA = "0.3_um_count_a"
        //        case the03_UmCountB = "0.3_um_count_b"
        //        case the05_UmCountA = "0.5_um_count_a"
        //        case the05_UmCountB = "0.5_um_count_b"
        //        case the10_UmCountA = "1.0_um_count_a"
        //        case the10_UmCountB = "1.0_um_count_b"
        //        case the25_UmCountA = "2.5_um_count_a"
        //        case the25_UmCountB = "2.5_um_count_b"
        //        case the50_UmCountA = "5.0_um_count_a"
        //        case the50_UmCountB = "5.0_um_count_b"
        //        case the100_UmCountA = "10.0_um_count_a"
        //        case the100_UmCountB = "10.0_um_count_b"
        //        case statsA = "stats_a"
        //        case statsB = "stats_b"
        //        case analogInput = "analog_input"
        //        case primaryIDA = "primary_id_a"
        //        case primaryKeyA = "primary_key_a"
        //        case secondaryIDA = "secondary_id_a"
        //        case secondaryKeyA = "secondary_key_a"
        //        case primaryIDB = "primary_id_b"
        //        case primaryKeyB = "primary_key_b"
        //        case secondaryIDB = "secondary_id_b"
        //        case secondaryKeyB = "secondary_key_b"
        //        case hardware
        //        case ledBrightness = "led_brightness"
        //        case firmwareUpgrade = "firmware_upgrade"
        //        case firmwareVersion = "firmware_version"
        //        case rssi, icon
        //        case confidenceManual = "confidence_manual"
        //        case confidenceAuto = "confidence_auto"
        //        case channelFlagsAuto = "channel_flags_auto"
        case stats
        
    }
    
    struct Stats: Codable {
        var pm25_10minute: Double?
        var pm25_30minute: Double?
        var pm25_60minute: Double?
        var pm25_6hour: Double?
        var pm25_24hour: Double?
        var pm25_1week: Double?
        
        enum CodingKeys: String, CodingKey {
            case pm25_10minute = "pm2.5_10minute"
            case pm25_30minute = "pm2.5_30minute"
            case pm25_60minute = "pm2.5_60minute"
            case pm25_6hour = "pm2.5_6hour"
            case pm25_24hour = "pm2.5_24hour"
            case pm25_1week = "pm2.5_1week"
        }
    }
}



//struct PurpleAirDataStructure: Codable {
////    var mapVersion, baseVersion, mapVersionString: String?
//    var results: [PurpleAirResult]?
//}
//
//struct PurpleAirResult: Codable {
//    var id: Int
//    var label: String
//    var deviceLocationtype: String?
////    var thingspeakPrimaryID, thingspeakPrimaryIDReadKey, thingspeakSecondaryID, thingspeakSecondaryIDReadKey: String
//    var lat, lon: Double?
//    var pm25Value: String?
////    var lastSeen: Int
////    var type: String?
////    var hidden: String
////    var deviceBrightness, deviceHardwarediscovered, deviceFirmwareversion, version: String?
////    var lastUpdateCheck: Int?
////    var created: Int
////    var uptime, rssi, adc: String?
////    var p0_3_Um, p0_5_Um, p1_0_Um, p2_5_Um: String
////    var p5_0_Um, p10_0_Um, pm10_CF1, pm25_CF1: String
////    var pm100_CF1, pm10_ATM, pm25_ATM, pm100_ATM: String
////    var isOwner: Int
//    var humidity, tempF, pressure: String?
//    var age: Int
////    var stats: String
////    var parentID: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "ID"
//        case label = "Label"
//        case deviceLocationtype = "DEVICE_LOCATIONTYPE"
////        case thingspeakPrimaryID = "THINGSPEAK_PRIMARY_ID"
////        case thingspeakPrimaryIDReadKey = "THINGSPEAK_PRIMARY_ID_READ_KEY"
////        case thingspeakSecondaryID = "THINGSPEAK_SECONDARY_ID"
////        case thingspeakSecondaryIDReadKey = "THINGSPEAK_SECONDARY_ID_READ_KEY"
//        case lat = "Lat"
//        case lon = "Lon"
//        case pm25Value = "PM2_5Value"
////        case lastSeen = "LastSeen"
////        case type = "Type"
////        case hidden = "Hidden"
////        case deviceBrightness = "DEVICE_BRIGHTNESS"
////        case deviceHardwarediscovered = "DEVICE_HARDWAREDISCOVERED"
////        case deviceFirmwareversion = "DEVICE_FIRMWAREVERSION"
////        case version = "Version"
////        case lastUpdateCheck = "LastUpdateCheck"
////        case created = "Created"
////        case uptime = "Uptime"
////        case rssi = "RSSI"
////        case adc = "Adc"
////        case p0_3_Um = "p_0_3_um"
////        case p0_5_Um = "p_0_5_um"
////        case p1_0_Um = "p_1_0_um"
////        case p2_5_Um = "p_2_5_um"
////        case p5_0_Um = "p_5_0_um"
////        case p10_0_Um = "p_10_0_um"
////        case pm10_CF1 = "pm1_0_cf_1"
////        case pm25_CF1 = "pm2_5_cf_1"
////        case pm100_CF1 = "pm10_0_cf_1"
////        case pm10_ATM = "pm1_0_atm"
////        case pm25_ATM = "pm2_5_atm"
////        case pm100_ATM = "pm10_0_atm"
////        case isOwner
//        case humidity
//        case tempF = "temp_f"
//        case pressure
//        case age = "AGE"
////        case stats = "Stats"
////        case parentID = "ParentID"
//    }
//}




// define an instance of the data that can be filled by the data loader and read by the menu
var purpleAirData = PurpleAirDataStructure()

public class DataLoaderPurpleAir {
    
    
    func loadPurpleAirData(id:String) {
        
        
        //        let headers = [
        //            "Accept": "application/json"
        //        ]
        //
        //        let request = NSMutableURLRequest(url: NSURL(string:
        //         "https://www.purpleair.com/json?key=\(APIKeyPurpleAir)&show=\(id)")! as URL,
        //                                                cachePolicy: .useProtocolCachePolicy,
        //                                                timeoutInterval: 10.0)
        
        let headers = [
            "Accept": "application/json",
            "X-API-Key": "\(APIKeyPurpleAirNewAPI)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://api.purpleair.com/v1/sensors/\(id)")! as URL,
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
                print("Miasma received from the Purple Air API")
//                if let data = data,
//                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
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
