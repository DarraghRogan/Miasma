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

var smartCitizenHistoricalData1d = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData3d = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData1w = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData1M = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData1y = SmartCitizenHistoricalDataStructure()

public class DataLoaderSmartCitizenHistorical {

        func loadSmartCitizenHistoricalData1d(id:String) {
            
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
                                                            "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_key=pm_avg_2.5&rollup=24h")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
    
            request.httpMethod = "GET"
    
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print("Miasma received from the SmartCitizen Historical 1d API")
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
                        smartCitizenHistoricalData1d = dataFromSmartCitizenHistorical
                    }
                    catch {
                        print("Error in SmartCitizen Historical 1d JSON parsing")
                        //                    print(purpleAirData)
                    }
                }
            })
            dataTask.resume()
        }
    
    func loadSmartCitizenHistoricalData3d(id:String) {
        
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
                                                        "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_key=pm_avg_2.5&rollup=72h")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)

        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Miasma received from the SmartCitizen Historical 3 day API")
//                if let data = data,
//                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
//                    let decoder = JSONDecoder()
                do {
                    let dataFromSmartCitizenHistorical = try newJSONDecoder().decode(SmartCitizenHistoricalDataStructure.self, from: data!)
                    smartCitizenHistoricalData3d = dataFromSmartCitizenHistorical
                }
                catch {
                    print("Error in SmartCitizen Historical 3 day JSON parsing")
                    //                    print(purpleAirData)
                }
            }
        })
        dataTask.resume()
    }
    
    func loadSmartCitizenHistoricalData1w(id:String) {
        
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
                                                        "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_key=pm_avg_2.5&rollup=168h")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)

        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Miasma received from the SmartCitizen Historical 1 Week API")
//                if let data = data,
//                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
//                    let decoder = JSONDecoder()
                do {
                    let dataFromSmartCitizenHistorical = try newJSONDecoder().decode(SmartCitizenHistoricalDataStructure.self, from: data!)
                    smartCitizenHistoricalData1w = dataFromSmartCitizenHistorical
                }
                catch {
                    print("Error in SmartCitizen Historical 1 Week JSON parsing")
                    //                    print(purpleAirData)
                }
            }
        })
        dataTask.resume()
    }
    
    func loadSmartCitizenHistoricalData1M(id:String) {
        
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
                                                        "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_key=pm_avg_2.5&rollup=1M")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)

        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Miasma received from the SmartCitizen Historical 1 Month API")
//                if let data = data,
//                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
//                    let decoder = JSONDecoder()
                do {
                    let dataFromSmartCitizenHistorical = try newJSONDecoder().decode(SmartCitizenHistoricalDataStructure.self, from: data!)
                    smartCitizenHistoricalData1M = dataFromSmartCitizenHistorical
                }
                catch {
                    print("Error in SmartCitizen Historical 1 Month JSON parsing")
                    //                    print(purpleAirData)
                }
            }
        })
        dataTask.resume()
    }
    
    func loadSmartCitizenHistoricalData1y(id:String) {
        
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
                                                        "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_key=pm_avg_2.5&rollup=1y")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)

        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Miasma received from the SmartCitizen Historical 1 Year API")
//                if let data = data,
//                   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
//                    let decoder = JSONDecoder()
                do {
                    let dataFromSmartCitizenHistorical = try newJSONDecoder().decode(SmartCitizenHistoricalDataStructure.self, from: data!)
                    smartCitizenHistoricalData1y = dataFromSmartCitizenHistorical
                }
                catch {
                    print("Error in SmartCitizen Historical 1 Year JSON parsing")
                    //                    print(purpleAirData)
                }
            }
        })
        dataTask.resume()
    }
}


