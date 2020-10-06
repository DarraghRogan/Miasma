//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct CO2DataStructure: Codable {
    var disclaimer, status, countryCode: String?
    var data: CO2DataClass?
    var units: CO2Units?

    enum CodingKeys: String, CodingKey {
        case disclaimer = "_disclaimer"
        case status, countryCode, data, units
    }
}

// MARK: - DataClass
struct CO2DataClass: Codable {
    var carbonIntensity, fossilFuelPercentage: Double
}

// MARK: - Units
struct CO2Units: Codable {
    var carbonIntensity: String
}


// define an instance of the data that can be filled by the data loader and read by the menu
var cO2Data = CO2DataStructure()

 public class DataLoaderCO2 {

    
    func loadCO2Data(lat:String, lon:String) {
        
        let headers = [
            "Accept": "application/json",
            "auth-token": "\(APIKeyCO2)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string:
            "https://api.co2signal.com/v1/latest?lon=\(lon)&lat=\(lat)")! as URL,
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
                print("Received from the CO2 API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromCO2 = try decoder.decode(CO2DataStructure.self, from: data!)
                    cO2Data = dataFromCO2

                }
                catch {
                    print("Error in CO2 JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
