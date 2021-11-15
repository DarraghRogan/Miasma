// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let smartCitizenHistoricalDataStructure = try? newJSONDecoder().decode(SmartCitizenHistoricalDataStructure.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.smartCitizenHistoricalDataStructureTask(with: url) { smartCitizenHistoricalDataStructure, response, error in
//     if let smartCitizenHistoricalDataStructure = smartCitizenHistoricalDataStructure {
//       ...
//     }
//   }
//   task.resume()

import Foundation

//extension URLSession {
//    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completionHandler(nil, response, error)
//                return
//            }
//            completionHandler(try? DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData(id: <#T##String#>).newJSONDecoder().decode(T.self, from: data), response, nil)
//        }
//    }
//
//    func smartCitizenHistoricalDataStructureTask(with url: URL, completionHandler: @escaping (SmartCitizenHistoricalDataStructure?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
//}

// MARK: - SmartCitizenHistoricalDataStructure
struct SmartCitizenHistoricalDataStructure: Codable {
    var deviceID: Int?
    var sensorKey: String?
    var sensorID, componentID: Int?
    var rollup, function: String?
    var from, to: Date?
    var sampleSize: Int?
    var readings: [[Reading]]?

    enum CodingKeys: String, CodingKey {
        case deviceID = "device_id"
        case sensorKey = "sensor_key"
        case sensorID = "sensor_id"
        case componentID = "component_id"
        case rollup, function, from, to
        case sampleSize = "sample_size"
        case readings
    }
}

enum Reading: Codable {
    case dateTime(Date)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Date.self) {
            self = .dateTime(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Reading.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Reading"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

var smartCitizenHistoricalData = SmartCitizenHistoricalDataStructure()


public class DataLoaderSmartCitizenHistorical {


// MARK: - Helper functions for creating encoders and decoders



        func loadSmartCitizenHistoricalData(id:String) {
            
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
    
            let request = NSMutableURLRequest(url: NSURL(string:
                                                            "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_id=87&rollup=24h")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
    
    
            request.httpMethod = "GET"
    
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
//                    let httpResponse = response as? HTTPURLResponse
//                    print("Miasma received from the SmartCitizen Historical API")
//                    if let data = data,
//                       let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                        print(urlContent)
//                    } else {
//                        print("error with printing string encoded data")
//                    }
                    //Parse JSON
//                    let decoder = JSONDecoder()
                    do {
                        let dataFromSmartCitizenHistorical = try newJSONDecoder().decode(SmartCitizenHistoricalDataStructure.self, from: data!)
                        smartCitizenHistoricalData = dataFromSmartCitizenHistorical
    
                    }
                    catch {
                        print("Error in SmartCitizen Historical JSON parsing")
                        //                    print(purpleAirData)
                    }
                }
            })
    
            dataTask.resume()
        }
    
}


