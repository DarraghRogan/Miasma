//
//  Location.swift
//  MapKitDemoN
//
//  Created by Nayem on 7/11/17.
//  Copyright © 2017 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation
import MapKit

enum PLISTError: String, Error  {
    case NoData = "ERROR: No Data"
    case ConversionFailed = "ERROR: Conversion form plist failed"
}

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
        guard let fileURL = Bundle.main.url(forResource: "Locations", withExtension: "plist") else {
            print("No file named Mountains in Main Bundle")
            return []
        }
        
        do {
            
            guard let data = try? Data(contentsOf: fileURL) else {
                throw PLISTError.NoData
            }
            
            guard let locations = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String:Any]] else {
                throw PLISTError.ConversionFailed
            }
            
            let result = locations.map({ (location) -> LocationWAQI in
                
                let title = location["title"] as? String
                let subtitle = location["description"] as? String
                let provider = location["provider"] as? String
                let latitude = location["latitude"] as? Double ?? 0, longitude = location["longitude"] as? Double ?? 0
                let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                
                return LocationWAQI(title: title, subtitle: subtitle, provider: provider, coordinate: coordinate)
            })
            return result
            
        } catch let error as PLISTError {
            print(error.rawValue)
            return []
        } catch let error as NSError {
            print(error.debugDescription)
            return []
        }
    }
    
    static var locationsWAQI: [LocationWAQI] {
        get {
            return loadLocationsWAQI()
        }
    }
    
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
