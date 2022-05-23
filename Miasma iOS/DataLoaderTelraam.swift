//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation
import Combine

struct TelraamResponse: Codable {
    let telraamData: [Feature]
    
            enum CodingKeys: String, CodingKey {
                case telraamData = "features"
            }
}

class TelraamViewModel: ObservableObject {
    
    @Published var telraamData = Feature()
    
    var telraamCancellationToken: AnyCancellable?
    
    init() {
        getTelraam()
//        print(telraamData)

    }
    
}

extension TelraamViewModel {
    
    func getTelraam() {

        telraamCancellationToken = TelraamDB.request(.segmentID)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                self.telraamData = $0.telraamData[0]
            })
    }
}

struct TelraamAPIClient {
    
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
                
//                print(Response<Any>.self)
//                print(result.response)
//                print(result.data)
                
                return Response(value: value, response: result.response)
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

enum TelraamDB {
    static let apiClient = TelraamAPIClient()
    static let baseUrl = URL(string: "https://telraam-api.net/v1/segments/id/\(ProfileEditor().segmentID)")!
}

enum TelraamAPIPath: String {
    case segmentID = ""
}

extension TelraamDB {
    
    static func request(_ path: TelraamAPIPath) -> AnyPublisher<TelraamResponse, Error> {
        
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URL Components")}
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        let headers = ["X-Api-Key": APIKeyTelraam]
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
//        print(request.url)

        return apiClient.run(request)
        
            .map(\.value)
            .eraseToAnyPublisher()
        
        
    }
}
// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct TelraamDataStructure: Codable {
    var statusCode: Int?
    var message, type: String?
    var features: [Feature]?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, type, features
    }
}

// MARK: - Feature
struct Feature: Codable {
    var type: String?
    //    var geometry: Geometry?
    var properties: Properties?
}

// MARK: - Geometry
//struct Geometry: Codable {
//    var type: String?
//    var coordinates: [[[Double]]]?
//}

// MARK: - Properties
struct Properties: Codable {
    var oidn: Int?
    var firstDataPackage, lastDataPackage: String?
    //    var speed: Int?
    //    var oneway: Bool?
    //    var roadType, roadSpeed: String?
    var pedestrian, bike, car, lorry: Double?
    //    var speedHistogram: [Double]?
    //    var speedBuckets: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case oidn
        case firstDataPackage = "first_data_package"
        case lastDataPackage = "last_data_package"
        //        case speed, oneway
        //        case roadType = "road_type"
        //        case roadSpeed = "road_speed"
        case pedestrian, bike, car, lorry
        //        case speedHistogram = "speed_histogram"
        //        case speedBuckets = "speed_buckets"
    }
}
