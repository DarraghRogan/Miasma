
//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation


// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct DailyAtmosphericCO2DataStructure: Codable {
    var co2: [Co2]?
}

// MARK: - Co2
struct Co2: Codable {
    var year, month, day, cycle: String?
    var trend: String?
}




// define an instance of the data that can be filled by the data loader and read by the menu
var dailyAtmosphericCO2Data = DailyAtmosphericCO2DataStructure()

 public class DataLoaderDailyAtmosphericCO2 {


    func loadDailyAtmosphericCO2Data(onComplete: @escaping () -> Void = {}) {

        let headers = ["Accept": "application/json"]

        let request = NSMutableURLRequest(url: NSURL(string:
            "https://global-warming.org/api/co2-api")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)

//        print(request.url)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            defer { onComplete() }
            if let error {
                print(error.localizedDescription)
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Request returned a non-HTTP response")
                    return
                }
                guard (200..<300).contains(httpResponse.statusCode) else {
                    print("Request failed with HTTP status \(httpResponse.statusCode)")
                    return
                }
                guard let data = data else {
                    print("Successful HTTP response contained no data")
                    return
                }
//                print("Received from the DailyAtmosphericCO2 API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromDailyAtmosphericCO2 = try decoder.decode(DailyAtmosphericCO2DataStructure.self, from: data)
                    dailyAtmosphericCO2Data = dataFromDailyAtmosphericCO2

                }
                catch {
                    print("Error in DailyAtmosphericCO2 JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
