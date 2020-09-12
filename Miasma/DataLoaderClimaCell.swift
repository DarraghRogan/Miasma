//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io


struct ClimaCellDataStructure: Codable {
//    var time: Int?
//    var states: [[State]]?
}


// define an instance of the data that can be filled by the data loader and read by the menu
var climaCellData = ClimaCellDataStructure()

public class DataLoaderClimaCell {

    
    func loadClimaCellData(lat:Double, lon:Double) {
        
        
        let headers = [
            "Accept": "application/json"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string:
            "https://api.climacell.co/v3/weather/realtime?lat=\(lat)&lon=\(lon)&unit_system=si&fields=pollen_tree%2Cpollen_grass%2Cpollen_weed%2Cfeels_like&apikey=\(APIKeyClimaCell)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        print(request)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Received from the ClimaCell API")
                if let data = data,
                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                    print(urlContent)
                } else {
                    print("error with printing string encoded data")
                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromClimaCell = try decoder.decode(ClimaCellDataStructure.self, from: data!)
                    climaCellData = dataFromClimaCell
                }
                catch {
                    print("Error in ClimaCell JSON parsing")
                }
                
            }
        })
        
        dataTask.resume()
    }
}
