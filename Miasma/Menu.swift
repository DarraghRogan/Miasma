//
//  Menu.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation
import Cocoa

    // Define the Menu
     let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
     let menu = NSMenu()

    var purpleAirLocation : NSMenuItem = {
       return NSMenuItem(title: "🗺: Loading (10s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirPM2_5 : NSMenuItem = {
        return NSMenuItem(title: "🌫: Loading (10s)", action: nil, keyEquivalent: "")
     }()

    var purpleAirTemperature : NSMenuItem = {
       return NSMenuItem(title: "🌡: Loading (10s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirHumidity : NSMenuItem = {
        return NSMenuItem(title: "💧: 🗣 Loading (10s)", action: nil, keyEquivalent: "")
     }()

    var purpleAirPressure : NSMenuItem = {
       return NSMenuItem(title: "💪: Loading (10s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirReadingAge : NSMenuItem = {
       return NSMenuItem(title: "⏳: Loading (10s)", action: nil, keyEquivalent: "")
    }()

// Define how to open windows & web addresses from menu

class menuFunctions{
    
   @objc func openPurpleAir(){
        NSWorkspace.shared.open(URL(string: "https://www.purpleair.com")!)
    }
    
    @objc func menuRefresh() {
        
        //        menu.removeAllItems()
        menuLoadOptionals()
        menuLoadNonOptionals()
        DataLoaderPurpleAir().loadPurpleAirData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
            purpleAirLocation.title = "🗺: \(String(purpleAirData.results?[0].label ?? ""))"
            purpleAirPM2_5.title = "🌫: \(String(purpleAirData.results?[0].pm25Value ?? "0"))µg/m³ PM₂.₅ (Current)"
            purpleAirTemperature.title = "🌡: \(String(purpleAirData.results?[0].tempF ?? "0"))℉"
            purpleAirHumidity.title = "💧: \(String(purpleAirData.results?[0].humidity ?? "0"))% Relative Humidity"
            purpleAirPressure.title = "💪: \(String(purpleAirData.results?[0].pressure ?? "0")) millibar"
            purpleAirReadingAge.title = "⏳: \(String(purpleAirData.results?[0].age ?? 0)) minutes old at Miama refresh time"

})
    }

// The function to manually run the data loaders, by loading the data, changing the menu bar to say loading, then after a delay filling in the correct data

func menuLoadOptionals() {
     
    menu.addItem(
    NSMenuItem(
     title: "Purple Air...",
     action: #selector(menuFunctions.openPurpleAir),
     keyEquivalent: "p"
     )
    )
    
    menu.addItem(purpleAirLocation)
    
    menu.addItem(purpleAirPM2_5)

    menu.addItem(purpleAirTemperature)
    
    menu.addItem(purpleAirHumidity)
    
    menu.addItem(purpleAirPressure)
    
    menu.addItem(purpleAirReadingAge)
    
    menu.addItem(
    NSMenuItem.separator()
    )
    
}
        
func menuLoadNonOptionals(){
    statusItem.button?.title = "ℳ"
    statusItem.button?.target = menu
    statusItem.menu = menu
        
    menu.addItem(
        NSMenuItem.separator()
        )

    menu.addItem(
        NSMenuItem(
            title: "Refresh (automatically every 10 minutes)",
            action: #selector(menuFunctions.menuRefresh),
            keyEquivalent: "r"
            )
        )
    
    menu.addItem(
        NSMenuItem(
            title: "Quit",
            action: Selector("terminate:"),
            keyEquivalent: "q")
                )
    

    
}
}

