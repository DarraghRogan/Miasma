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
        DataLoaderAPICovid19().loadAPICovid19Data()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
            self.purpleAirLocation.title = "🗺: \(String(purpleAirData.results?[0].label ?? ""))"
            
            var pM2_5Value = Double(purpleAirData.results?[0].pm25Value ?? "0") ?? 0
            let pM2_5ColourButton: String
                switch (pM2_5Value) {
                    case _ where pM2_5Value >= 0 && pM2_5Value < 12:
                        pM2_5ColourButton = "[🟢_______]"
                    case _ where pM2_5Value > 12 && pM2_5Value < 35:
                        pM2_5ColourButton = "[_🟡______]"
                    case _ where pM2_5Value > 35 && pM2_5Value < 55:
                        pM2_5ColourButton = "[__🟠_____]"
                    case _ where pM2_5Value > 55 && pM2_5Value < 150:
                        pM2_5ColourButton = "[___🔴____]"
                    case _ where pM2_5Value > 150 && pM2_5Value < 250:
                        pM2_5ColourButton = "[____🟣___]"
                    case _ where pM2_5Value > 250 && pM2_5Value < 350:
                        pM2_5ColourButton = "[_____🟣__]"
                    case _ where pM2_5Value > 350 && pM2_5Value < 500:
                        pM2_5ColourButton = "[______🟤_]"
                    case _ where pM2_5Value > 500:
                        pM2_5ColourButton = "[_______🟤]"
                    default:
                        pM2_5ColourButton = ""
                }
            self.purpleAirPM2_5.title = "☁️: \(String(purpleAirData.results?[0].pm25Value ?? "0"))µg/m³ PM₂.₅ (Current)   \(pM2_5ColourButton)"
            
            let Fahrenheit: Double = Double(purpleAirData.results?[0].tempF ?? "0")!
            func calculateCelsius(fahrenheit: Double) -> String {
                var celsius: Double
                celsius = (fahrenheit - 32) * 5 / 9
                let celciusRoundedString = String(format: "%.1f", locale: Locale.current, celsius)
                return celciusRoundedString
            }
            self.purpleAirTemperature.title = "🌡: \(String(purpleAirData.results?[0].tempF ?? "0"))℉ / \(calculateCelsius(fahrenheit: Fahrenheit))℃"
            
            self.purpleAirHumidity.title = "💧: \(String(purpleAirData.results?[0].humidity ?? "0"))% Relative Humidity"
            
            var pressureValue = Double(purpleAirData.results?[0].pressure ?? "0") ?? 0
            let pressure_visual: String
            // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                switch (pressureValue) {
                    case _ where pressureValue < 1009.144:
                        pressure_visual = "[Low/______/____]"
                    case _ where pressureValue > 1009.144 && pressureValue < 1022.689:
                        pressure_visual = "[___/Normal/____]"
                    case _ where pressureValue > 1022.689:
                        pressure_visual = "[___/______/High]"
                    default:
                        pressure_visual = ""
                }
            self.purpleAirPressure.title = "🌬️: \(String(purpleAirData.results?[0].pressure ?? "0")) millibar            \(pressure_visual)"
            self.purpleAirReadingAge.title = "⏳: \(String(purpleAirData.results?[0].age ?? 0)) minute(s) old at Ⓜiasma refresh time"
            })
    }
    
// Define the initial variables for each menu entry
    
    var purpleAirLocation : NSMenuItem = {
       return NSMenuItem(title: "🗺: Loading (5s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirPM2_5 : NSMenuItem = {
        return NSMenuItem(title: "🌫: Loading (5s)", action: nil, keyEquivalent: "")
     }()

    var purpleAirTemperature : NSMenuItem = {
       return NSMenuItem(title: "🌡: Loading (5s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirHumidity : NSMenuItem = {
        return NSMenuItem(title: "💧: 🗣 Loading (5s)", action: nil, keyEquivalent: "")
     }()

    var purpleAirPressure : NSMenuItem = {
       return NSMenuItem(title: "🌬️: Loading (5s)", action: nil, keyEquivalent: "")
    }()

    var purpleAirReadingAge : NSMenuItem = {
       return NSMenuItem(title: "⏳: Loading (5s)", action: nil, keyEquivalent: "")
    }()

// Define how to open windows & web addresses from menu
   @objc func openPurpleAir(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "http://www.purpleair.com/map")!)
    }
    
    
    @objc func menuRefresh(_ sender: NSMenuItem) {
        menuFunctions()
    }

    func menuLoadNonOptionals(){
        statusItem.button?.title = "Ⓜ"
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
