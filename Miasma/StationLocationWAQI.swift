//
//  Location.swift
//  MapKitDemoN
//
//  Created by Nayem on 7/11/17.
//  Copyright © 2017 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation
import MapKit

struct StationsFromWAQI: Codable {
    var status: String?
    var data: [DatumWAQI]?
}

struct DatumWAQI: Codable {
    var lat, lon: Double?
    var uid: Int?
    var aqi: String?
    var station: StationWAQI?
}


struct StationWAQI: Codable {
    var name: String?
    var time: Date?
}

var wAQIStations = StationsFromWAQI()

class LocationWAQI: NSObject, MKAnnotation {
        
    var title: String?
    var subtitle: String?
    var provider: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, provider: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.provider = provider
        self.coordinate = coordinate
    }
    
    static func loadLocationsWAQI() -> [LocationWAQI] {
        //        guard let fileURL = Bundle.main.url(forResource: "Locations", withExtension: "plist") else {
        //            print("No file named Mountains in Main Bundle")
        //            return []
        //        }
        //
        //        do {
        //
        //            guard let data = try? Data(contentsOf: fileURL) else {
        //                throw PLISTError.NoData
        //            }
        //
        //            guard let locations = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String:Any]] else {
        //                throw PLISTError.ConversionFailed
        //            }
        //
        //            let result = locations.map({ (location) -> LocationWAQI in
        //
        //                let title = location["title"] as? String
        //                let subtitle = location["description"] as? String
        //                let provider = location["provider"] as? String
        //                let latitude = location["latitude"] as? Double ?? 0, longitude = location["longitude"] as? Double ?? 0
        //                let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        //
        //                return LocationWAQI(title: title, subtitle: subtitle, provider: provider, coordinate: coordinate)
        //            })
        //            return result
        //
        //        } catch let error as PLISTError {
        //            print(error.rawValue)
        //            return []
        //        } catch let error as NSError {
        //            print(error.debugDescription)
        //            return []
        //        }
        let headers = [
            "Accept": "application/json"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://api.waqi.info/map/bounds/?latlng=85,-180,-85,180&token=\(APIKeyWAQI)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //        print(request)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //                print("Received from the ClimaCell API")
                //                if let data = data,
                //                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                //                    print(urlContent)
                //                } else {
                //                    print("error with printing string encoded data")
                //                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let stationsFromWAQI = try decoder.decode(StationsFromWAQI.self, from: data!)
                    wAQIStations = stationsFromWAQI
                }
                catch {
                    print("Error in ClimaCell JSON parsing")
                }
                
            }
        })
        
        dataTask.resume()
    }
        
    let location = wAQIStations.map({ (wAQIStations: LocationWAQI) -> LocationWAQI in

            let title = wAQIStations["title"] as? String
            let subtitle = wAQIStations["description"] as? String
            let provider = wAQIStations["provider"] as? String
            let latitude = wAQIStations["latitude"] as? Double ?? 0, longitude = wAQIStations["longitude"] as? Double ?? 0
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            return wAQIStations
    })
        
        
        class func createViewAnnotationForMapView(_ mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
            // try to dequeue an existing pin view first
            var returnedAnnotationView =
                mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: LocationWAQI.self))
            if returnedAnnotationView == nil {
                returnedAnnotationView =
                    MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(describing: LocationWAQI.self))
                
                let pinAnnotationView = returnedAnnotationView as! MKPinAnnotationView
                if #available(OSX 10.11, *) {
                    pinAnnotationView.pinTintColor = MKPinAnnotationView.greenPinColor()
                }
                pinAnnotationView.animatesDrop = true
                pinAnnotationView.canShowCallout = true
                
                let rightButton = NSButton(frame: NSMakeRect(0.0, 0.0, 100.0, 80.0))
                rightButton.title = "Choose"
                rightButton.target = self
                rightButton.action = #selector(ViewController.locationChooseAction(_:))
                rightButton.bezelStyle = .shadowlessSquare
                returnedAnnotationView!.rightCalloutAccessoryView = rightButton
                
                
            }
            
            return returnedAnnotationView!
        }
        
    }
