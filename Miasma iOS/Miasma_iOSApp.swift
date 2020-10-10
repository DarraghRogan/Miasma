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
    
    
    
    
    // Triggered by the menu's refresh button
    func updateDataSources(){
        
        ContentView()
        
//        switch (ProfileEditor().AirQualityDataSource) {
//
//        case _ where ProfileEditor().AirQualityDataSource == "WAQI/AQICN" :
////            DataLoaderWAQI().loadWAQIData(id: "\(ProfileEditor().SensorID)")
//            WAQIViewModel().getWAQI()
//
//        case _ where ProfileEditor().AirQualityDataSource == "PurpleAir" :
//            PurpleAirViewModel().getPurpleAir()
//
//        default:
//            WAQIViewModel().getWAQI()
//            
//        }
        

    }
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
