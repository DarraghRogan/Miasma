//
//  AppDelegate.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // Define the User Defaults to hold settings
    public let defaults = UserDefaults.standard
//    AppDelegate().defaults.set("59111", forKey: "YouTubeInUse")


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application


        // Run the dataloaders at app startup
         menuFunctions().menuRefresh()
        
        // periodically update the menu
        let timer = Timer.scheduledTimer(withTimeInterval: 600.0, repeats: true) { timer in
            menuFunctions().menuRefresh()
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

