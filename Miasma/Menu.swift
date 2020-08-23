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

class menuFunctions: NSObject {

// Initialise the menu
    override init() {
        super.init()
        menu.removeAllItems()
        menuLoadOptionals()
        menuLoadNonOptionals()
        DataLoaderPurpleAir().loadPurpleAirData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.1, execute: {
            self.purpleAirLocation.title = "🗺: \(String(purpleAirData.results?[0].label ?? ""))"
            self.purpleAirPM2_5.title = "🌫: \(String(purpleAirData.results?[0].pm25Value ?? "0"))µg/m³ PM₂.₅ (Current)"
            
            let Fahrenheit: Double = Double(purpleAirData.results?[0].tempF ?? "0")!
            func calculateCelsius(fahrenheit: Double) -> String {
                var celsius: Double
                celsius = (fahrenheit - 32) * 5 / 9
                let celciusRoundedString = String(format: "%.1f", locale: Locale.current, celsius)
                return celciusRoundedString
            }
            self.purpleAirTemperature.title = "🌡: \(String(purpleAirData.results?[0].tempF ?? "0"))℉ / \(calculateCelsius(fahrenheit: Fahrenheit))℃"
            
            self.purpleAirHumidity.title = "💧: \(String(purpleAirData.results?[0].humidity ?? "0"))% Relative Humidity"
            self.purpleAirPressure.title = "💪: \(String(purpleAirData.results?[0].pressure ?? "0")) millibar"
            self.purpleAirReadingAge.title = "⏳: \(String(purpleAirData.results?[0].age ?? 0)) minute(s) old at Miasma refresh time"
            })
    }
    
// Define the initial variables for each menu entry
    
    var purpleAirLocation : NSMenuItem = {
       return NSMenuItem(title: "🗺: Loading (3s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirPM2_5 : NSMenuItem = {
        return NSMenuItem(title: "🌫: Loading (3s)", action: nil, keyEquivalent: "")
     }()

    var purpleAirTemperature : NSMenuItem = {
       return NSMenuItem(title: "🌡: Loading (3s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirHumidity : NSMenuItem = {
        return NSMenuItem(title: "💧: 🗣 Loading (3s)", action: nil, keyEquivalent: "")
     }()

    var purpleAirPressure : NSMenuItem = {
       return NSMenuItem(title: "💪: Loading (3s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirReadingAge : NSMenuItem = {
       return NSMenuItem(title: "⏳: Loading (3s)", action: nil, keyEquivalent: "")
    }()

// Define how to open windows & web addresses from menu
   @objc func openPurpleAir(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "http://www.purpleair.com/map")!)
    }
    
    
    @objc func menuRefresh(_ sender: NSMenuItem) {
        menuFunctions()
    }

    func menuLoadNonOptionals(){
        statusItem.button?.title = "ℳ"
        statusItem.button?.target = self
        statusItem.menu = menu
            
        menu.addItem(
            NSMenuItem.separator()
            )
        
        let menuRefresh = NSMenuItem(
            title: "Refresh (automatically every 10 minutes)",
            action: #selector(menuFunctions.menuRefresh(_:)),
            keyEquivalent: "r"
        )
        menuRefresh.target = self
        menu.addItem(menuRefresh)
        
        menu.addItem(
            NSMenuItem(
                title: "Quit",
                action: Selector("terminate:"),
                keyEquivalent: "q")
                    )
    }
    
// The function to manually run the data loaders, by loading the data, changing the menu bar to say loading, then after a delay filling in the correct data

    func menuLoadOptionals() {
        
        let purpleAir = NSMenuItem(
            title: "PurpleAir...",
            action: #selector(menuFunctions.openPurpleAir(_:)),
            keyEquivalent: "p"
        )
        purpleAir.target = self
        menu.addItem(purpleAir)
        
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
        
}
