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
    var data: DataClass1?
}

// MARK: - DataClass
struct DataClass1: Codable {
    var timelines: [Timeline]?
}

// MARK: - Timeline
struct Timeline: Codable {
    //    var timestep: String?
    //    var startTime, endTime: Date?
    var intervals: [Interval]?
}

// MARK: - Interval
struct Interval: Codable {
    //    var startTime: Date?
    var values: Values?
}

// MARK: - Values
struct Values: Codable {
    var treeIndex, grassIndex, weedIndex: Double?
    var temperatureApparent: Double?
    var weatherCode: Int?
    var windDirection, windSpeed: Double?
    var epaIndex, epaPrimaryPollutant: Int?
    var solarGHI: Double?
    var uvIndex: Double?
    var precipitationProbability: Double?
    var rainAccumulation: Double?
}


// define an instance of the data that can be filled by the data loader and read by the menu
var climaCellData = ClimaCellDataStructure()
var climaCellErrorMessage: String?

public class DataLoaderClimaCell {
    
    
    func loadClimaCellData(lat:Double, lon:Double, onComplete: @escaping () -> Void = {}) {
        climaCellErrorMessage = nil

        
        let fieldNames = [
            "treeIndex", "grassIndex", "weedIndex", "temperatureApparent",
            "weatherCode", "windDirection", "windSpeed", "epaIndex",
            "epaPrimaryPollutant", "solarGHI", "uvIndex"
        ]
        var components = URLComponents(string: "https://api.tomorrow.io/v4/timelines")
        components?.queryItems = [
            URLQueryItem(name: "location", value: "\(lat),\(lon)"),
            URLQueryItem(name: "fields", value: fieldNames.joined(separator: ",")),
            URLQueryItem(name: "timesteps", value: "1h"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "startTime", value: "now"),
            URLQueryItem(name: "endTime", value: "nowPlus6h"),
            URLQueryItem(name: "apikey", value: APIKeyClimaCellV4)
        ]

        guard let url = components?.url else {
            climaCellErrorMessage = "Could not create the Tomorrow.io request URL."
            onComplete()
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { onComplete() }

            if let error {
                climaCellErrorMessage = error.localizedDescription
                print("Tomorrow.io request failed: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                climaCellErrorMessage = "Tomorrow.io returned an invalid response."
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                let responseBody = data.flatMap { String(data: $0, encoding: .utf8) } ?? ""
                climaCellErrorMessage = "Tomorrow.io returned HTTP \(httpResponse.statusCode). \(responseBody)"
                print(climaCellErrorMessage ?? "Tomorrow.io request failed.")
                return
            }

            guard let data else {
                climaCellErrorMessage = "Tomorrow.io returned an empty response."
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(ClimaCellDataStructure.self, from: data)
                guard let intervals = decodedData.data?.timelines?.first?.intervals, !intervals.isEmpty else {
                    climaCellErrorMessage = "Tomorrow.io returned no hourly forecast intervals."
                    return
                }

                climaCellData = decodedData
                climaCellErrorMessage = nil
            } catch {
                climaCellErrorMessage = "Could not read Tomorrow.io weather data: \(error.localizedDescription)"
                print(climaCellErrorMessage ?? "Tomorrow.io response decoding failed.")
            }
        }

        dataTask.resume()
    }
}
