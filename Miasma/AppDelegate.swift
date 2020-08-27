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
    
    // Technique from https://stackoverflow.com/questions/55995415/nsmenuitem-with-action-added-to-nsstatusbar-is-grayed-out-when-the-selected-func to get status bar actions working
    var statusBarItemController: menuFunctions?

    // Define the User Defaults to hold settings
    public let defaults = UserDefaults.standard

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        // Technique from https://stackoverflow.com/questions/55995415/nsmenuitem-with-action-added-to-nsstatusbar-is-grayed-out-when-the-selected-func to get status bar actions working
        statusBarItemController = menuFunctions()
        
        // Run the dataloaders at app startup
//        menuFunctions().menuRefresh(NSMenuItem)
        
        // periodically update the menu
        _ = Timer.scheduledTimer(withTimeInterval: 600.0, repeats: true) { timer in
            self.statusBarItemController = menuFunctions()        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

