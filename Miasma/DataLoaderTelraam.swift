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
    var disclaimer, status, countryCode: String?
    var data: TelraamDataClass?
    var units: TelraamUnits?

    enum CodingKeys: String, CodingKey {
        case disclaimer = "_disclaimer"
        case status, countryCode, data, units
    }
}

// MARK: - DataClass
struct TelraamDataClass: Codable {
    var carbonIntensity, fossilFuelPercentage: Double
}

// MARK: - Units
struct TelraamUnits: Codable {
    var carbonIntensity: String
}


// define an instance of the data that can be filled by the data loader and read by the menu
var telraamData = TelraamDataStructure()

 public class DataLoaderTelraam {

    
    func loadTelraamData(segmentID:Int) {
        
        let headers = [
            "Accept": "application/json",
//            "auth-token": "\(APIKeyTelraam)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string:
            "https://telraam-api.net/v0/segments/id/\(segmentID)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        
//        print(request.url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

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
