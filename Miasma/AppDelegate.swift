//
//  AppDelegate.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa
import ServiceManagement


// Launching asutomatically at startup from tutorial: https://theswiftdev.com/how-to-launch-a-macos-app-at-login/
extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    // Technique from https://stackoverflow.com/questions/55995415/nsmenuitem-with-action-added-to-nsstatusbar-is-grayed-out-when-the-selected-func to get status bar actions working
    var statusBarItemController: menuFunctions?
    
    // Define the User Defaults to hold settings
    public let defaults = UserDefaults.standard
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // setting first launch to default to using WAQI with "here" as the city, to give users a nice first impression. Following technique from: https://medium.com/better-programming/checking-for-the-users-first-launch-in-swift-df02a1feb472
        
        if defaults.bool(forKey: "First Launch") == true {
            
        } else {
            
            defaults.set(true, forKey: "First Launch")
            defaults.set("here", forKey: "WAQICity")
            defaults.set(1, forKey: "WAQIInUse")
            defaults.set(1, forKey:"CO2SignalInUse")
            defaults.set(1, forKey:"OpenSkyInUse")
            
        }
        
        // Launching automatically at startup from tutorial: https://theswiftdev.com/how-to-launch-a-macos-app-at-login/
        
        let launcherAppId = "Darragh-Rogan.MiasmaLauncher"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
        
        //        SMLoginItemSetEnabled(launcherAppId as CFString, true)
        
        if isRunning {
            DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
        }
        
        
        // Technique from https://stackoverflow.com/questions/55995415/nsmenuitem-with-action-added-to-nsstatusbar-is-grayed-out-when-the-selected-func to get status bar actions working
        statusBarItemController = menuFunctions()
        
        // Run the dataloaders at app startup
        //        menuFunctions().menuRefresh(NSMenuItem)
        
        // periodically update the menu
        _ = Timer.scheduledTimer(withTimeInterval: 1200.0, repeats: true) { timer in
            self.statusBarItemController = menuFunctions()        }
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

