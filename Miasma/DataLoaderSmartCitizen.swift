//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct SmartCitizenDataStructure: Codable {
    var id: Int?
    var uuid, name, welcomeDescription, state: String?
    var hardwareInfo: HardwareInfo?
    var systemTags, userTags: [String]?
    var isPrivate, notifyLowBattery, notifyStoppedPublishing: Bool?
    var lastReadingAt, addedAt, updatedAt: Date?
    var macAddress: String?
    var owner: Owner?
    var data: DataClass?
    var kit: Kit?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case welcomeDescription
        case state
        case hardwareInfo
        case systemTags
        case userTags
        case isPrivate
        case notifyLowBattery
        case notifyStoppedPublishing
        case lastReadingAt
        case addedAt
        case updatedAt
        case macAddress
        case owner, data, kit
    }
}

// MARK: Welcome convenience initializers and mutators

extension SmartCitizenDataStructure {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SmartCitizenDataStructure.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        uuid: String?? = nil,
        name: String?? = nil,
        welcomeDescription: String?? = nil,
        state: String?? = nil,
        hardwareInfo: HardwareInfo?? = nil,
        systemTags: [String]?? = nil,
        userTags: [String]?? = nil,
        isPrivate: Bool?? = nil,
        notifyLowBattery: Bool?? = nil,
        notifyStoppedPublishing: Bool?? = nil,
        lastReadingAt: Date?? = nil,
        addedAt: Date?? = nil,
        updatedAt: Date?? = nil,
        macAddress: String?? = nil,
        owner: Owner?? = nil,
        data: DataClass?? = nil,
        kit: Kit?? = nil
    ) -> SmartCitizenDataStructure {
        return SmartCitizenDataStructure(
            id: id ?? self.id,
            uuid: uuid ?? self.uuid,
            name: name ?? self.name,
            welcomeDescription: welcomeDescription ?? self.welcomeDescription,
            state: state ?? self.state,
            hardwareInfo: hardwareInfo ?? self.hardwareInfo,
            systemTags: systemTags ?? self.systemTags,
            userTags: userTags ?? self.userTags,
            isPrivate: isPrivate ?? self.isPrivate,
            notifyLowBattery: notifyLowBattery ?? self.notifyLowBattery,
            notifyStoppedPublishing: notifyStoppedPublishing ?? self.notifyStoppedPublishing,
            lastReadingAt: lastReadingAt ?? self.lastReadingAt,
            addedAt: addedAt ?? self.addedAt,
            updatedAt: updatedAt ?? self.updatedAt,
            macAddress: macAddress ?? self.macAddress,
            owner: owner ?? self.owner,
            data: data ?? self.data,
            kit: kit ?? self.kit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    var recordedAt, addedAt: Date?
    var location: DataLocation?
    var sensors: [SmartCitizenSensor]?

    enum CodingKeys: String, CodingKey {
        case recordedAt
        case addedAt
        case location, sensors
    }
}

// MARK: DataClass convenience initializers and mutators

extension DataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        recordedAt: Date?? = nil,
        addedAt: Date?? = nil,
        location: DataLocation?? = nil,
        sensors: [SmartCitizenSensor]?? = nil
    ) -> DataClass {
        return DataClass(
            recordedAt: recordedAt ?? self.recordedAt,
            addedAt: addedAt ?? self.addedAt,
            location: location ?? self.location,
            sensors: sensors ?? self.sensors
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DataLocation
struct DataLocation: Codable {
    var ip: JSONNull?
    var exposure: String?
    var elevation: JSONNull?
    var latitude, longitude: Double?
    var geohash, city, countryCode, country: String?

    enum CodingKeys: String, CodingKey {
        case ip, exposure, elevation, latitude, longitude, geohash, city
        case countryCode
        case country
    }
}

// MARK: DataLocation convenience initializers and mutators

extension DataLocation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataLocation.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        ip: JSONNull?? = nil,
        exposure: String?? = nil,
        elevation: JSONNull?? = nil,
        latitude: Double?? = nil,
        longitude: Double?? = nil,
        geohash: String?? = nil,
        city: String?? = nil,
        countryCode: String?? = nil,
        country: String?? = nil
    ) -> DataLocation {
        return DataLocation(
            ip: ip ?? self.ip,
            exposure: exposure ?? self.exposure,
            elevation: elevation ?? self.elevation,
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude,
            geohash: geohash ?? self.geohash,
            city: city ?? self.city,
            countryCode: countryCode ?? self.countryCode,
            country: country ?? self.country
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sensor
struct SmartCitizenSensor: Codable {
    var id: Int?
    var ancestry: String?
    var name, sensorDescription, unit: String?
    var createdAt, updatedAt: Date?
    var measurementID: Int?
    var uuid: String?
    var value, rawValue, prevValue, prevRawValue: Double?

    enum CodingKeys: String, CodingKey {
        case id, ancestry, name
        case sensorDescription
        case unit
        case createdAt
        case updatedAt
        case measurementID
        case uuid, value
        case rawValue
        case prevValue
        case prevRawValue
    }
}

// MARK: Sensor convenience initializers and mutators

extension SmartCitizenSensor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SmartCitizenSensor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        ancestry: String?? = nil,
        name: String?? = nil,
        sensorDescription: String?? = nil,
        unit: String?? = nil,
        createdAt: Date?? = nil,
        updatedAt: Date?? = nil,
        measurementID: Int?? = nil,
        uuid: String?? = nil,
        value: Double?? = nil,
        rawValue: Double?? = nil,
        prevValue: Double?? = nil,
        prevRawValue: Double?? = nil
    ) -> SmartCitizenSensor {
        return SmartCitizenSensor(
            id: id ?? self.id,
            ancestry: ancestry ?? self.ancestry,
            name: name ?? self.name,
            sensorDescription: sensorDescription ?? self.sensorDescription,
            unit: unit ?? self.unit,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            measurementID: measurementID ?? self.measurementID,
            uuid: uuid ?? self.uuid,
            value: value ?? self.value,
            rawValue: rawValue ?? self.rawValue,
            prevValue: prevValue ?? self.prevValue,
            prevRawValue: prevRawValue ?? self.prevRawValue
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - HardwareInfo
struct HardwareInfo: Codable {
    var id, mac: String?
    var time: Date?
    var espBd, hwVer: String?
    var samBd: Date?
    var espVer, samVer: String?

    enum CodingKeys: String, CodingKey {
        case id, mac, time
        case espBd
        case hwVer
        case samBd
        case espVer
        case samVer
    }
}

// MARK: HardwareInfo convenience initializers and mutators

extension HardwareInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HardwareInfo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        mac: String?? = nil,
        time: Date?? = nil,
        espBd: String?? = nil,
        hwVer: String?? = nil,
        samBd: Date?? = nil,
        espVer: String?? = nil,
        samVer: String?? = nil
    ) -> HardwareInfo {
        return HardwareInfo(
            id: id ?? self.id,
            mac: mac ?? self.mac,
            time: time ?? self.time,
            espBd: espBd ?? self.espBd,
            hwVer: hwVer ?? self.hwVer,
            samBd: samBd ?? self.samBd,
            espVer: espVer ?? self.espVer,
            samVer: samVer ?? self.samVer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Kit
struct Kit: Codable {
    var id: Int?
    var uuid, slug, name, kitDescription: String?
    var createdAt, updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, uuid, slug, name
        case kitDescription
        case createdAt
        case updatedAt
    }
}

// MARK: Kit convenience initializers and mutators

extension Kit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Kit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        uuid: String?? = nil,
        slug: String?? = nil,
        name: String?? = nil,
        kitDescription: String?? = nil,
        createdAt: Date?? = nil,
        updatedAt: Date?? = nil
    ) -> Kit {
        return Kit(
            id: id ?? self.id,
            uuid: uuid ?? self.uuid,
            slug: slug ?? self.slug,
            name: name ?? self.name,
            kitDescription: kitDescription ?? self.kitDescription,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Owner
struct Owner: Codable {
    var id: Int?
    var uuid, username: String?
    var avatar: String?
    var url: JSONNull?
    var joinedAt: Date?
    var location: OwnerLocation?
    var deviceIDS: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id, uuid, username, avatar, url
        case joinedAt
        case location
        case deviceIDS
    }
}

// MARK: Owner convenience initializers and mutators

extension Owner {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Owner.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        uuid: String?? = nil,
        username: String?? = nil,
        avatar: String?? = nil,
        url: JSONNull?? = nil,
        joinedAt: Date?? = nil,
        location: OwnerLocation?? = nil,
        deviceIDS: [JSONAny]?? = nil
    ) -> Owner {
        return Owner(
            id: id ?? self.id,
            uuid: uuid ?? self.uuid,
            username: username ?? self.username,
            avatar: avatar ?? self.avatar,
            url: url ?? self.url,
            joinedAt: joinedAt ?? self.joinedAt,
            location: location ?? self.location,
            deviceIDS: deviceIDS ?? self.deviceIDS
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OwnerLocation
struct OwnerLocation: Codable {
    var city, country, countryCode: JSONNull?

    enum CodingKeys: String, CodingKey {
        case city, country
        case countryCode
    }
}

// MARK: OwnerLocation convenience initializers and mutators

extension OwnerLocation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OwnerLocation.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        city: JSONNull?? = nil,
        country: JSONNull?? = nil,
        countryCode: JSONNull?? = nil
    ) -> OwnerLocation {
        return OwnerLocation(
            city: city ?? self.city,
            country: country ?? self.country,
            countryCode: countryCode ?? self.countryCode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
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





// define an instance of the data that can be filled by the data loader and read by the menu
var smartCitizenData = SmartCitizenDataStructure()

 public class DataLoaderSmartCitizen {

    
    func loadSmartCitizenData(id:String) {

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
                print("Received from the SmartCitizen API")
                if let data = data,
                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                    print(urlContent)
                } else {
                    print("error with printing string encoded data")
                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromSmartCitizen = try decoder.decode(SmartCitizenDataStructure.self, from: data!)
                    smartCitizenData = dataFromSmartCitizen

                }
                catch {
                    print("Error in SmartCitizen JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
