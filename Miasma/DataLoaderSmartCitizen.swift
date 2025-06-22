//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct SmartCitizenPresentDataStructure: Codable {
        var id: Int?
    //    var uuid,
    var name: String?
    //       var welcomeDescription, state: String?
        var hardware: HardwareInfo?
    //    var systemTags, userTags: [String]?
    //    var isPrivate, notifyLowBattery, notifyStoppedPublishing: Bool?
    //    var lastReadingAt, addedAt, updatedAt: Date?
    //    var macAddress: String?
    var owner: Owner?
    var location: DataLocation?
    var data: SmartCitizenDataClass?
    //    var kit: Kit?
    
    enum CodingKeys: String, CodingKey {
        //        case id
        //        case uuid
        case name
        //        case welcomeDescription = "description"
        //        case state
        //        case hardwareInfo = "hardware_info"
        //        case systemTags = "system_tags"
        //        case userTags = "user_tags"
        //        case isPrivate = "is_private"
        //        case notifyLowBattery = "notify_low_battery"
        //        case notifyStoppedPublishing = "notify_stopped_publishing"
        //        case lastReadingAt = "last_reading_at"
        //        case addedAt = "added_at"
        //        case updatedAt = "updated_at"
        //        case macAddress = "mac_address"
        case owner, data, hardware
        //             case kit
    }
}

// MARK: - DataClass
struct SmartCitizenDataClass: Codable {
    //    var recordedAt, addedAt: Date?
    var location: DataLocation?
    var sensors: [SmartCitizenSensor]?
    
    enum CodingKeys: String, CodingKey {
        //        case recordedAt = "recorded_at"
        //        case addedAt = "added_at"
        case location
        case sensors
    }
}

// MARK: - DataLocation
struct DataLocation: Codable {
    //    var ip: JSONNull?
    var exposure: String?
    //    var elevation: JSONNull?
    var latitude, longitude: Double?
    //    var geohash: String?
    var city, countryCode, country: String?
    
    enum CodingKeys: String, CodingKey {
        //        case ip
        case exposure
        //                  case elevation
        case latitude, longitude
        //                  case geohash
        case city
        case countryCode = "country_code"
        case country
    }
}

// MARK: - Sensor
struct SmartCitizenSensor: Codable {
    //    var id: Int?
    //    var ancestry: String?
    var name, sensorDescription, unit, default_key: String?
    //    var createdAt, updatedAt: Date?
    var measurementID: Int?
    //    var uuid: String?
    var value, rawValue, prevValue, prevRawValue: Double?
    
    enum CodingKeys: String, CodingKey {
        //        case id, ancestry
        case name
        case default_key
        case sensorDescription = "description"
        case unit
        //        case createdAt = "created_at"
        //        case updatedAt = "updated_at"
        case measurementID = "measurement_id"
        //        case uuid
        case value
        case rawValue = "raw_value"
        case prevValue = "prev_value"
        case prevRawValue = "prev_raw_value"
    }
}

// MARK: - HardwareInfo
struct HardwareInfo: Codable {
    var version: String?
    var id, mac: String?
    var time: Date?
    var espBd, hwVer: String?
    var samBd: Date?
    var espVer, samVer: String?
    
    enum CodingKeys: String, CodingKey {
        case id, mac, time, version
        case espBd = "esp_bd"
        case hwVer = "hw_ver"
        case samBd = "sam_bd"
        case espVer = "esp_ver"
        case samVer = "sam_ver"
    }
}

// MARK: - Kit
struct Kit: Codable {
    var id: Int?
    var uuid, slug, name, kitDescription: String?
    var createdAt, updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, uuid, slug, name
        case kitDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Owner
struct Owner: Codable {
//    var id: Int?
//    var uuid, username: String?
//    var avatar: String?
    //    var url: JSONNull?
//    var joinedAt: Date?
    var location: OwnerLocation?
//    var deviceIDS: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
//        case id, uuid, username, avatar
//        //        case url
//        case joinedAt = "joined_at"
        case location
//        case deviceIDS = "device_ids"
    }
}

// MARK: - OwnerLocation
struct OwnerLocation: Codable {
    var city, country, countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case city, country
        case countryCode = "country_code"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}





//struct SmartCitizenHistoricalDataStructure: Codable {
//
//    var componentId : Int?
//    var deviceId : Int?
//    var from : String?
//    var function : String?
//
//
//}

// define an instance of the data that can be filled by the data loader and read by the menu
var smartCitizenPresentData = SmartCitizenPresentDataStructure()

//var smartCitizenHistoricalData = SmartCitizenHistoricalDataStructure()


public class DataLoaderSmartCitizen {
    
    
    func loadSmartCitizenPresentData(id:String) {
        
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://api.smartcitizen.me/v0/devices/\(id)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
//                print("Miasma received from the SmartCitizen Present API")
//                if let data = data,
//                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromSmartCitizenPresent = try decoder.decode(SmartCitizenPresentDataStructure.self, from: data!)
                    smartCitizenPresentData = dataFromSmartCitizenPresent
                    
                }
                catch {
                    print("Error in SmartCitizen Present JSON parsing")
                    //                    print(purpleAirData)
                }
            }
        })
        
        dataTask.resume()
    }
    
    
//    func loadSmartCitizenHistoricalData(id:String) {
//
//        let request = NSMutableURLRequest(url: NSURL(string:
//                                                        "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_id=87&rollup=24h&from=2021-07-29&to=2021-07-31")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//
//
//        request.httpMethod = "GET"
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print("Miasma received from the SmartCitizen Historical API")
//                if let data = data,
//                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
//                //Parse JSON
//                let decoder = JSONDecoder()
//                do {
//                    let dataFromSmartCitizenHistorical = try decoder.decode(SmartCitizenHistoricalDataStructure.self, from: data!)
//                    smartCitizenHistoricalData = dataFromSmartCitizenHistorical
//
//                }
//                catch {
//                    print("Error in SmartCitizen Historical JSON parsing")
//                    //                    print(purpleAirData)
//                }
//            }
//        })
//
//        dataTask.resume()
//    }
    
}
