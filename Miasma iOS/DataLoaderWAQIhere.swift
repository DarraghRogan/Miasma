//
//  DataLoader.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation
import Combine

struct WAQIhereResponse: Codable {
    let wAQIdata: WAQIDataClass

    enum CodingKeys: String, CodingKey {
        case wAQIdata = "data"
    }
}

class WAQIhereViewModel: ObservableObject {

    @Published var wAQIdata: WAQIDataClass = WAQIDataClass()

    @Published var loadState: DataLoadState = .idle


    var wAQICancellationToken: AnyCancellable?

}

extension WAQIhereViewModel {

    func getWAQIhere(onComplete: @escaping () -> Void = {}) {
        loadState = .loading
        wAQICancellationToken = WAQIhereDB.request(.city)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.loadState = .loaded
                    onComplete()
                case .failure(let error):
                    self.loadState = .failed(error.localizedDescription)
                    onComplete()
                }
            }, receiveValue: {
                    self.wAQIdata = $0.wAQIdata
            })
//        print(ProfileEditor().SensorID)
//        print(_wAQIdata)
    }
}

struct WAQIhereAPIClient {

    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    func run<T: Decodable>(_ request: URLRequest) ->
    AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in

                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw NSError(domain: "Miasma.HTTP", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP request failed with status code \(httpResponse.statusCode)"])
                }
                let value = try JSONDecoder().decode(
                    T.self, from: result.data)

//                                print(Response<Any>.self)
//                                print(result.response)
return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
}

enum WAQIhereDB {
    static let apiClient = WAQIhereAPIClient()
    static let baseUrl = URL(string: "https://api.waqi.info/feed/here")!
}

enum WAQIhereAPIPath: String {
    case city = "/"
}

extension WAQIhereDB {

    static func request(_ path: WAQIhereAPIPath) -> AnyPublisher<WAQIhereResponse, Error> {

        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URL Components")}
        components.queryItems = [URLQueryItem(name: "token", value: APIKeyWAQI)]

        let request = URLRequest(url: components.url!)

//        print(request)

        return apiClient.run(request)

            .map(\.value)
            .eraseToAnyPublisher()
    }
}
