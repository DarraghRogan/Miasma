import Foundation

struct SmartCitizenHistoricalDataStructure: Codable {
    var deviceID: Int?
    var sensorKey: String?
    var sensorID, componentID: Int?
    var rollup, function: String?
    var from, to: Date?
    var sampleSize: Int?
    var readings: [[Reading]]?

    enum CodingKeys: String, CodingKey {
        case deviceID = "device_id"
        case sensorKey = "sensor_key"
        case sensorID = "sensor_id"
        case componentID = "component_id"
        case rollup, function, from, to
        case sampleSize = "sample_size"
        case readings
    }
}

enum Reading: Codable {
    case dateTime(Date)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let date = try? container.decode(Date.self) {
            self = .dateTime(date)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else {
            throw DecodingError.typeMismatch(
                Reading.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Reading")
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let date):
            try container.encode(date)
        case .double(let value):
            try container.encode(value)
        }
    }
}

var smartCitizenHistoricalData1d = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData3d = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData1w = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData1M = SmartCitizenHistoricalDataStructure()
var smartCitizenHistoricalData1y = SmartCitizenHistoricalDataStructure()

public final class DataLoaderSmartCitizenHistorical {
    private func load(
        id: String,
        rollup: String,
        onComplete: @escaping () -> Void,
        onValue: @escaping (SmartCitizenHistoricalDataStructure) -> Void
    ) {
        guard let url = URL(string: "https://api.smartcitizen.me/v0/devices/\(id)/readings?sensor_key=pm_avg_2.5&rollup=\(rollup)") else {
            DispatchQueue.main.async(execute: onComplete)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            var result: SmartCitizenHistoricalDataStructure?
            if let error {
                print(error)
            } else if let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode),
                      let data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    result = try decoder.decode(SmartCitizenHistoricalDataStructure.self, from: data)
                } catch {
                    print("Unable to decode SmartCitizen historical readings: \(error)")
                }
            }

            DispatchQueue.main.async {
                if let result {
                    onValue(result)
                }
                onComplete()
            }
        }.resume()
    }

    func loadSmartCitizenHistoricalData1d(id: String, onComplete: @escaping () -> Void = {}) {
        load(id: id, rollup: "24h", onComplete: onComplete) { smartCitizenHistoricalData1d = $0 }
    }

    func loadSmartCitizenHistoricalData3d(id: String, onComplete: @escaping () -> Void = {}) {
        load(id: id, rollup: "72h", onComplete: onComplete) { smartCitizenHistoricalData3d = $0 }
    }

    func loadSmartCitizenHistoricalData1w(id: String, onComplete: @escaping () -> Void = {}) {
        load(id: id, rollup: "168h", onComplete: onComplete) { smartCitizenHistoricalData1w = $0 }
    }

    func loadSmartCitizenHistoricalData1M(id: String, onComplete: @escaping () -> Void = {}) {
        load(id: id, rollup: "1M", onComplete: onComplete) { smartCitizenHistoricalData1M = $0 }
    }

    func loadSmartCitizenHistoricalData1y(id: String, onComplete: @escaping () -> Void = {}) {
        load(id: id, rollup: "1y", onComplete: onComplete) { smartCitizenHistoricalData1y = $0 }
    }
}
