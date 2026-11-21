import Foundation

struct CO2DataStructure: Codable {
    var zone: String?
    var carbonIntensity: Int?
    var datetime: String?
    var updatedAt: String?
    var createdAt: String?
    var emissionFactorType: String?
    var isEstimated: Bool?
    var estimationMethod: String?
    var temporalGranularity: String?
}

var cO2Data = CO2DataStructure()

public class DataLoaderCO2 {
    func loadCO2Data(lat: String, lon: String) {
        guard var components = URLComponents(string: "https://api.electricitymaps.com/v3/carbon-intensity/latest") else { return }
        components.queryItems = [
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "lat", value: lat)
        ]
        guard let url = components.url else { return }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(APIKeyCO2, forHTTPHeaderField: "auth-token")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode),
                  let data,
                  let decoded = try? JSONDecoder().decode(CO2DataStructure.self, from: data) else { return }
            cO2Data = decoded
        }.resume()
    }
}
