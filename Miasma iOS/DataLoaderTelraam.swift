import Foundation
import Combine

struct TelraamDataStructure: Codable {
    var statusCode: Int?
    var message: String?
    var report: [TelraamReport]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, report
    }
}

struct TelraamReport: Codable {
    var pedestrian: Double?
    var bike: Double?
    var car: Double?
    var heavy: Double?

    enum CodingKeys: String, CodingKey {
        case pedestrian, bike, car, heavy
    }
}

struct Feature {
    var properties: Properties?
}

struct Properties {
    var pedestrian: Double?
    var bike: Double?
    var car: Double?
    var lorry: Double?
}

class TelraamViewModel: ObservableObject {
    @Published var telraamData = Feature(properties: Properties())
    private var dataTask: URLSessionDataTask?

    func getTelraam() {
        let segmentID = ProfileEditor().segmentID
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())

        guard let url = URL(string: "https://telraam-api.net/v1/reports/traffic") else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(APIKeyTelraam, forHTTPHeaderField: "X-Api-Key")
        request.httpBody = try? JSONSerialization.data(withJSONObject: [
            "level": "segments",
            "id": segmentID,
            "format": "per-hour",
            "time_start": "\(date) 00:00:00Z",
            "time_end": "\(date) 23:00:00Z"
        ])

        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode),
                  let data,
                  let reports = try? JSONDecoder().decode(TelraamDataStructure.self, from: data).report,
                  !reports.isEmpty else { return }

            let totals = reports.reduce(into: TelraamReport()) { total, report in
                total.pedestrian = (total.pedestrian ?? 0) + (report.pedestrian ?? 0)
                total.bike = (total.bike ?? 0) + (report.bike ?? 0)
                total.car = (total.car ?? 0) + (report.car ?? 0)
                total.heavy = (total.heavy ?? 0) + (report.heavy ?? 0)
            }

            DispatchQueue.main.async {
                self?.telraamData = Feature(properties: Properties(
                    pedestrian: totals.pedestrian,
                    bike: totals.bike,
                    car: totals.car,
                    lorry: totals.heavy
                ))
            }
        }
        dataTask?.resume()
    }
}
