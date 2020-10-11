//
//  Miasma_iOSApp.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // set up user defaults for people
        // this is where returning users should end up
      if defaults.bool(forKey: "First Launch") == true  {

     } else {
        // default config for new users

         defaults.set(true, forKey: "First Launch")
         defaults.set("here", forKey: "SensorID")
         defaults.set("WAQI/AQICN", forKey: "AirQualityDataSource")
         defaults.set(true, forKey:"ElectricalConsumptionDataWanted")
         defaults.set(true, forKey:"AircraftDataWanted")
         defaults.set(true, forKey:"OneHourForecastDataWanted")
     }
        
        return true
        
    }
    // Define the User Defaults to hold settings
    public let defaults = UserDefaults.standard
}


@main

struct Miasma_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            // this is where I should have a reload function to allow the user change their station ID in the app preferences
            ContentView()
            
        }
    }
}

struct Miasma_iOSApp_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
