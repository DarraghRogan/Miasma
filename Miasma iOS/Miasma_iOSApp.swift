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
        
        updateDataSources()
        
        return true
        
    }
    // Define the User Defaults to hold settings
    public let defaults = UserDefaults.standard
    
    func updateDataSources(){
        switch (ProfileEditor().AirQualityDataSource) {
        
        case _ where ProfileEditor().AirQualityDataSource == "WAQI/AQICN" :
            DataLoaderWAQI().loadWAQIData(id: "\(ProfileEditor().SensorID)")
            print("called for the WAQI data loader")
            
        case _ where ProfileEditor().AirQualityDataSource == "PurpleAir" :
            DataLoaderPurpleAir().loadPurpleAirData(id: "\(ProfileEditor().SensorID)")
            
        default:
            DataLoaderWAQI().loadWAQIData(id: "here")
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.05) { // sort of URL session task
            
            print("called for the other data loaders")

            DataLoaderCO2().loadCO2Data(lat: String(ContentView().sensorLatitude), lon: String(ContentView().sensorLongitude))
            
            DataLoaderOpenSky().loadOpenSkyData(lamin: ((ContentView().sensorLatitude )-1), lomin: ((ContentView().sensorLongitude )-1), lamax: ((ContentView().sensorLatitude)+1), lomax: ((ContentView().sensorLongitude)+1))
            
            DataLoaderClimaCell().loadClimaCellData(lat: ContentView().sensorLatitude, lon: ContentView().sensorLongitude)
            
        }
    }
}


@main

struct Miasma_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
            
        }
    }
}

struct Miasma_iOSApp_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
