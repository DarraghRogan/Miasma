//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct APICovid19DataStructure: Codable {
//    var welcomeGet: String? =""
//    var parameters: APICovid19Parameters?
//        var errors: [APICovid19JSONAny]
//    var results: Int? = 0
    var response: [APICovid19Response]?

//    enum CodingKeys: String, CodingKey {
//        case welcomeGet = "get"
//        case parameters, errors, results, response
//    }
}

struct APICovid19Parameters: Codable {
    var country: String
}

struct APICovid19Response: Codable {
    var continent, country: String
    var population: Int
    var cases: APICovid19Cases
    var deaths: APICovid19Deaths
    var tests: APICovid19Tests
    var day: String
    var time: String
}

struct APICovid19Cases: Codable {
    var new: String
    var active, critical, recovered: Int
    var the1MPop: String
    var total: Int

    enum CodingKeys: String, CodingKey {
        case new, active, critical, recovered
        case the1MPop = "1M_pop"
        case total
    }
}

struct APICovid19Deaths: Codable {
    var new: String?
    var the1MPop: String
    var total: Int

    enum CodingKeys: String, CodingKey {
        case new
        case the1MPop = "1M_pop"
        case total
    }
}

struct APICovid19Tests: Codable {
    var the1MPop: String
    var total: Int

    enum CodingKeys: String, CodingKey {
        case the1MPop = "1M_pop"
        case total
    }
}




// define an instance of the data that can be filled by the data loader and read by the menu
var aPICovid19Data = APICovid19DataStructure()

 public class DataLoaderAPICovid19 {

    
    func loadAPICovid19Data() {

        
        let headers = [
            "x-rapidapi-key":"\(APIKeyAPICovid19)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string:
            "https://covid-193.p.rapidapi.com/statistics?country=Ireland")! as URL,
 //           "https://www.purpleair.com/json?key=\(APIKeyPurpleAir)&show=\(AppDelegate().defaults.object(forKey:"PurpleAirStation") as? String ?? String())")! as URL,
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
//                print("Received from the API-Covid-19 API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromAPICovid19 = try decoder.decode(APICovid19DataStructure.self, from: data!)
                    aPICovid19Data = dataFromAPICovid19
                    print(aPICovid19Data.response?[0].country)
                    print(aPICovid19Data.response?[0].cases.new)
                    print(aPICovid19Data.response?[0].cases.the1MPop)
                    print(aPICovid19Data.response?[0].deaths.new)
                    print(aPICovid19Data.response?[0].deaths.the1MPop)
                    print(aPICovid19Data.response?[0].tests.the1MPop)
                    print(aPICovid19Data.response?[0].time)

                }
                catch {
                    print("Error in API-Covid-19 JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
