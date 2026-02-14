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
    var zone: String?
    var carbonIntensity: Int?
    var datetime, updatedAt, createdAt, emissionFactorType: String?
    var isEstimated: Bool?
    var estimationMethod, temporalGranularity: String?
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
            "https://api.electricitymaps.com/v3/carbon-intensity/latest?lon=\(lon)&lat=\(lat)")! as URL,
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
                print("Miasma received from the ElectricityMaps CO2 API")
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
                    print("Error in CO2 Signal JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
