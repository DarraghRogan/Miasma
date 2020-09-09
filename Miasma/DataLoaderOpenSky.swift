//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io


struct OpenSkyDataStructure: Codable {
        var time: Int?
        var states: [[State]]?
    }

    enum State: Codable {
        case bool(Bool)
        case double(Double)
        case string(String)
        case null

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Bool.self) {
                self = .bool(x)
                return
            }
            if let x = try? container.decode(Double.self) {
                self = .double(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if container.decodeNil() {
                self = .null
                return
            }
            throw DecodingError.typeMismatch(State.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for State"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .bool(let x):
                try container.encode(x)
            case .double(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            case .null:
                try container.encodeNil()
            }
        }
    }


// define an instance of the data that can be filled by the data loader and read by the menu
var openSkyData = OpenSkyDataStructure()

 public class DataLoaderOpenSky {

    var arrayss = [String:Any]()
    var keys = [String]()
    var stateCount = 0

    
    func loadOpenSkyData() {

        
        let headers = [
            "Accept": "application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string:
         "https://opensky-network.org/api/states/all?lamin=45.8389&lomin=5.9962&lamax=47.8229&lomax=10.5226")! as URL,
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
                print("Received from the OpenSky API")
                if let data = data,
                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                    print(urlContent)
                } else {
                    print("error with printing string encoded data")
                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromOpenSky = try decoder.decode(OpenSkyDataStructure.self, from: data!)
                    openSkyData = dataFromOpenSky
                    
                    let counts = openSkyData.states?.count
                    print(counts)
                    //(into: [:]) { $0[$1, default: 0] += 1 }

                }
                catch {
                    print("Error in OpenSky JSON parsing")
//                    print(purpleAirData)
                }
                
            }
        })

        dataTask.resume()
    }
 }
