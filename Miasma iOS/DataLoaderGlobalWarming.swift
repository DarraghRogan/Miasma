//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct GlobalWarmingDataStructure: Codable {
    var error: JSONNull?
    var result: [Result]?
}

struct Result: Codable {
    var time, station, land: String?
}





// define an instance of the data that can be filled by the data loader and read by the menu
var globalWarmingData = GlobalWarmingDataStructure()

 public class DataLoaderGlobalWarming {

    
    func loadGlobalWarmingData(onComplete: @escaping () -> Void = {}) {
        
        let headers = [
            "Accept": "application/json",
        ]

        let request = NSMutableURLRequest(url: NSURL(string:
            "https://global-warming.org/api/temperature-api")! as URL,
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
//                print("Received from the GlobalWarming API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromGlobalWarming = try decoder.decode(GlobalWarmingDataStructure.self, from: data)
                    globalWarmingData = dataFromGlobalWarming

                }
                catch {
                    print("Error in GlobalWarming JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
