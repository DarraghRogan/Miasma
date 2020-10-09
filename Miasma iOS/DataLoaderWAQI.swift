//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation
import Combine

struct WAQIResponse: Codable {
    let wAQIdata: WAQIDataStructure

    enum CodingKeys: String, CodingKey {
        case wAQIdata = "results"
    }
}

class WAQIViewModel: ObservableObject {
    
    @Published var wAQIdata: WAQIDataStructure = WAQIDataStructure()
    
    var wAQICancellationToken: AnyCancellable?
    
    init() {
        getWAQI()
    }
}

extension WAQIViewModel {
    
    func getWAQI() {
        wAQICancellationToken = WAQIDB.request(.here)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.wAQIdata = $0.wAQIdata
                  })
    }
}

struct WAQIAPIClient {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) ->
    AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(
                    T.self, from: result.data)
                                                     return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum WAQIDB {
    static let apiClient = WAQIAPIClient()
    static let baseUrl = URL(string: "https://api.waqi.info/feed/")!
}

enum WAQIAPIPath: String {
    case here = "here/"
}

extension WAQIDB {
    
    static func request(_ path: WAQIAPIPath) -> AnyPublisher<WAQIResponse, Error> {
        
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URL Components")}
        components.queryItems = [URLQueryItem(name: "token", value: APIKeyWAQI)]
        
        let request = URLRequest(url: components.url!)
        
        print(request)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct WAQIDataStructure: Codable {
    var status: String?
    var data: WAQIDataClass?
}

struct WAQIDataClass: Codable {
    var aqi, idx: Int
    var attributions: [WAQIAttribution]
    var city: WAQICity
    var dominentpol: String
    var iaqi: WAQIIaqi
    var time: WAQITime
////    var forecast: WAQIForecast
//    var debug: WAQIDebug
}

struct WAQIAttribution: Codable {
    var url: String
    var name: String
//    var logo: String?
}

struct WAQICity: Codable {
    var geo: [Double]
    var name: String
    var url: String
}

struct WAQIDebug: Codable {
    var sync: Date
}

//struct WAQIForecast: Codable {
//    var daily: WAQIDaily
//}
//
//struct WAQIDaily: Codable {
//    var o3, pm10, pm25, uvi: [WAQIO3]
//}

struct WAQIO3: Codable {
    var avg: Int
    var day: String
    var max, min: Int
}

struct WAQIIaqi: Codable {
    var co: WAQICo?
    var h: WAQICo?
    var no2: WAQICo?
    var o3: WAQICo?
    var p, pm10, pm25, so2: WAQICo?
    var t, w, wg: WAQICo?
}

struct WAQICo: Codable {
    var v: Double
}

struct WAQITime: Codable {
    var s, tz: String
    var v: Int
//    var iso: Date
}




// define an instance of the data that can be filled by the data loader and read by the menu
var wAQIData = WAQIDataStructure()

 public class DataLoaderWAQI {

    
    func loadWAQIData(id:String) {

        let request = NSMutableURLRequest(url: NSURL(string:
            "https://api.waqi.info/feed/\(id)/?token=\(APIKeyWAQI)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        
        
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Received from the WAQI API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromWAQI = try decoder.decode(WAQIDataStructure.self, from: data!)
                    wAQIData = dataFromWAQI

                }
                catch {
                    print("Error in WAQI JSON parsing")
//                    print(purpleAirData)
                }
            }
        })

        dataTask.resume()
    }
 }
