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
            
            ContentView().environmentObject(UserData())
            
        }
    }
}

struct Miasma_iOSApp_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
