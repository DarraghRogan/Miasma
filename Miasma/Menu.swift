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
    }
    
    
    // Define the initial variables for each menu entry
    
    var purpleAirLocation : NSMenuItem = {
        return NSMenuItem(title: "🌍: ", action: nil, keyEquivalent: "")
    }()
    
    var purpleAirPM2_5 : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()
    
    var purpleAirTemperature : NSMenuItem = {
        return NSMenuItem(title: "🌡: ", action: nil, keyEquivalent: "")
    }()
    
    var purpleAirHumidity : NSMenuItem = {
        return NSMenuItem(title: "💧: ", action: nil, keyEquivalent: "")
    }()
    
    var purpleAirPressure : NSMenuItem = {
        return NSMenuItem(title: "🌬️: ", action: nil, keyEquivalent: "")
    }()
    
    var purpleAirReadingAge : NSMenuItem = {
        return NSMenuItem(title: "⏳: ", action: nil, keyEquivalent: "")
    }()
    
    var purpleAirPM2_5StatusBarIcon : NSMenuItem = {
        return NSMenuItem(title: "", action: nil, keyEquivalent: "")
    }()
    
    var wAQIAQIColourButton : NSMenuItem = {
        return NSMenuItem(title: "", action: nil, keyEquivalent: "")
    }()
    
    var wAQICity : NSMenuItem = {
        return NSMenuItem(title: "🌍: ", action: nil, keyEquivalent: "")
    }()
    
    var wAQIAttribution : NSMenuItem = {
        return NSMenuItem(title: "📜: ", action: nil, keyEquivalent: "")
    }()
    
    var wAQIAQI : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()
    
    var wAQIDominentPol : NSMenuItem = {
        return NSMenuItem(title: "🎯: ", action: nil, keyEquivalent: "")
    }()
    
    var wAQITemperature : NSMenuItem = {
        return NSMenuItem(title: "🌡: ", action: nil, keyEquivalent: "")
    }()
    
    var wAQITime : NSMenuItem = {
        return NSMenuItem(title: "📅: ", action: nil, keyEquivalent: "")
    }()
    
    
    var cO2Country : NSMenuItem = {
        return NSMenuItem(title: "🌍: ", action: nil, keyEquivalent: "")
    }()
    
    var cO2carbonIntensity : NSMenuItem = {
        return NSMenuItem(title: "🔥: ", action: nil, keyEquivalent: "")
    }()
    
    var cO2fossilFuelPercentage : NSMenuItem = {
        return NSMenuItem(title: "🦖: ", action: nil, keyEquivalent: "")
    }()
    
    var openSkyAircraftInBox : NSMenuItem = {
        return NSMenuItem(title: "✈️: ", action: nil, keyEquivalent: "")
    }()

    
    
    // Define how to open windows & web addresses from menu
    @objc func openPurpleAir(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.purpleair.com/map?opt=1/mPM25/a10/cC0&select=\(AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String())")!)
    }
    
    @objc func openWAQI(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "\(wAQIData.data?.city.url ?? "https://aqicn.org/here/")")!)
    }
    
    @objc func openCO2(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.electricitymap.org/")!)
    }
    
    @objc func openOpenSky(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://opensky-network.org/")!)
    }
    
    @objc func menuRefresh(_ sender: NSMenuItem) {
        menu.removeAllItems()
        menuLoadOptionals()
        menuLoadNonOptionals()
    }
    
    @objc func openAboutMiasma(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "http://miasma.kissengineering.ie")!)
    }
    
    @objc func menuReview(_ sender: NSMenuItem){
        //         NSWorkspace.shared.open(URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
        
    }
    
    @objc func showPreferences(_ sender: Any) {
        var myWindow: NSWindow? = nil
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"),bundle: nil)
        let controller = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("PreferencesStoryboard")) as! NSViewController
        myWindow = NSWindow(contentViewController: controller)
        NSApp.activate(ignoringOtherApps: true)
        myWindow?.makeKeyAndOrderFront(self)
        let vc = NSWindowController(window: myWindow)
        vc.showWindow(self)
    }
    
    func menuLoadNonOptionals(){
        statusItem.button?.title = "M ⚪"
        statusItem.button?.target = self
        statusItem.menu = menu
        
        menu.addItem(
            NSMenuItem.separator()
        )
        
        let menuRefresh = NSMenuItem(
            title: "Refresh (automatically every 10 mins)",
            action: #selector(menuFunctions.menuRefresh(_:)),
            keyEquivalent: "r"
        )
        menuRefresh.target = self
        menu.addItem(menuRefresh)
        
        let menuPreferences = NSMenuItem(
            title: "Miasma Preferences...",
            action: #selector(menuFunctions.showPreferences(_:)),
            keyEquivalent: ","
        )
        menuPreferences.target = self
        menu.addItem(menuPreferences)
        
        let menuReview = NSMenuItem(
            title: "Review / Suggest Improvements for Miasma...",
            action: #selector(menuFunctions.menuReview(_:)),
            keyEquivalent: "e"
        )
        menuReview.target = self
        menu.addItem(menuReview)
        
        let aboutMiasma = NSMenuItem(
            title: "About Miasma...",
            action: #selector(menuFunctions.openAboutMiasma(_:)),
            keyEquivalent: "a"
        )
        aboutMiasma.target = self
        menu.addItem(aboutMiasma)
        
        menu.addItem(
            NSMenuItem(
                title: "Quit",
                action: Selector("terminate:"),
                keyEquivalent: "q")
        )
    }
    
    // The function to manually run the data loaders, by loading the data, changing the menu bar to say loading, then after a delay filling in the correct data
    
    func menuLoadOptionals() {
        
        if AppDelegate().defaults.integer(forKey:"PurpleAirInUse") == 1 {
            
            
            let purpleAir = NSMenuItem(
                title: "Air Quality (PurpleAir)...",
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
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                
                menu.addItem(NSMenuItem.separator())
                let CO2Link = NSMenuItem(
                    title: "Electricity Consumption (CO2 Signal)...",
                    action: #selector(menuFunctions.openCO2(_:)),
                    keyEquivalent: "c"
                )
                CO2Link.target = self
                menu.addItem(CO2Link)
                
                menu.addItem(cO2Country)
                menu.addItem(cO2carbonIntensity)
                menu.addItem(cO2fossilFuelPercentage)
                
            }
            
            if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                
                menu.addItem(NSMenuItem.separator())
                let OpenSkyLink = NSMenuItem(
                    title: "Aircraft Overhead (OpenSky)...",
                    action: #selector(menuFunctions.openOpenSky(_:)),
                    keyEquivalent: "o"
                )
                OpenSkyLink.target = self
                menu.addItem(OpenSkyLink)
                
                menu.addItem(openSkyAircraftInBox)

            }
            
            DataLoaderPurpleAir().loadPurpleAirData(id: (AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                    DataLoaderCO2().loadCO2Data(lat: String(purpleAirData.results?[0].lat ?? 0), lon: String(purpleAirData.results?[0].lon ?? 0))
                }
                
                if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: ((purpleAirData.results?[0].lat ?? 0)-1), lomin: ((purpleAirData.results?[0].lon ?? 0)-1), lamax: ((purpleAirData.results?[0].lat ?? 0)+1), lomax: ((purpleAirData.results?[0].lon ?? 0)+1))
                }
                
                self.purpleAirLocation.title = "🌍: \(String(purpleAirData.results?[0].label ?? "0")); Type: \(String(purpleAirData.results?[0].deviceLocationtype ?? "0"))"
                
                var pM2_5Value = Double(purpleAirData.results?[0].pm25Value ?? "") ?? 0
                let pM2_5ColourButton: String
                switch (pM2_5Value) {
                case _ where pM2_5Value > 0 && pM2_5Value < 12:
                    pM2_5ColourButton = "[🟢_______]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟢"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                case _ where pM2_5Value > 12 && pM2_5Value < 35:
                    pM2_5ColourButton = "[_🟡______]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟡"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                case _ where pM2_5Value > 35 && pM2_5Value < 55:
                    pM2_5ColourButton = "[__🟠_____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟠"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                case _ where pM2_5Value > 55 && pM2_5Value < 150:
                    pM2_5ColourButton = "[___🔴____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🔴"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                case _ where pM2_5Value > 150 && pM2_5Value < 250:
                    pM2_5ColourButton = "[____🟣___]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟣"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                case _ where pM2_5Value > 250 && pM2_5Value < 350:
                    pM2_5ColourButton = "[_____🟣__]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟣"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                case _ where pM2_5Value > 350 && pM2_5Value < 500:
                    pM2_5ColourButton = "[______🟤_]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟤"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                case _ where pM2_5Value > 500:
                    pM2_5ColourButton = "[_______🟤]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟤"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                default:
                    pM2_5ColourButton = ""
                    self.purpleAirPM2_5StatusBarIcon.title = "⚪"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                }
                self.purpleAirPM2_5.title = "☁️: \(String(purpleAirData.results?[0].pm25Value ?? "0"))µg/m³ PM₂.₅ (Current)   \(pM2_5ColourButton)"
                
                let PurpleAirFahrenheit: Double = Double(purpleAirData.results?[0].tempF ?? "0")!
                func calculateCelsius(fahrenheit: Double) -> String {
                    var celsius: Double
                    celsius = (fahrenheit - 32) * 5 / 9
                    let celciusRoundedString = String(format: "%.1f", locale: Locale.current, celsius)
                    return celciusRoundedString
                }
                self.purpleAirTemperature.title = "🌡: \(calculateCelsius(fahrenheit: PurpleAirFahrenheit))℃ / \(String(purpleAirData.results?[0].tempF ?? "0"))℉"
                
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
                self.purpleAirReadingAge.title = "⏳: \(String(purpleAirData.results?[0].age ?? 0)) minute(s) old at Miasma refresh time"
            })
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.cO2Country.title = "🌍: Carbon Intensity of Electricity Consumption in \(cO2Data.countryCode ?? "")"
                    self.cO2carbonIntensity.title = "🔥: \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.carbonIntensity ?? 0)) \(cO2Data.units?.carbonIntensity ?? "")"
                    self.cO2fossilFuelPercentage.title = "🦖: \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.fossilFuelPercentage ?? 0))% fossil fueled"
                    
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.openSkyAircraftInBox.title = "✈️: \(String(format: "%U", locale: Locale.current, openSkyData.states?.count ?? 0)) aircraft in ±1° latitude/longitude box over Air Quality sensor"
                })
            }
            
        }
        
        
        
        if AppDelegate().defaults.integer(forKey:"WAQIInUse") == 1 {
            
            let WAQILink = NSMenuItem(
                title: "World Air Quality Index...",
                action: #selector(menuFunctions.openWAQI(_:)),
                keyEquivalent: "w"
            )
            WAQILink.target = self
            menu.addItem(WAQILink)
            
            menu.addItem(wAQICity)
            menu.addItem(wAQIAttribution)
            menu.addItem(wAQIAQI)
            menu.addItem(wAQIDominentPol)
            menu.addItem(wAQITemperature)
            menu.addItem(wAQITime)
            
            menu.addItem(NSMenuItem.separator())
            let CO2Link = NSMenuItem(
                title: "CO2 Signal (Electricity Consumption)...",
                action: #selector(menuFunctions.openCO2(_:)),
                keyEquivalent: "c"
            )
            CO2Link.target = self
            menu.addItem(CO2Link)
            
            menu.addItem(cO2Country)
            menu.addItem(cO2carbonIntensity)
            menu.addItem(cO2fossilFuelPercentage)
            
            DataLoaderWAQI().loadWAQIData(id: (AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                DataLoaderCO2().loadCO2Data(lat: String(wAQIData.data?.city.geo[1] ?? 0), lon: String(wAQIData.data?.city.geo[0] ?? 0))
                
                
                if wAQIData.status == "ok" {
                    
                    self.wAQICity.title = "🌍: \(String(wAQIData.data?.city.name ?? "0"))"
                    self.wAQIAttribution.title = "📜: \(String(wAQIData.data?.attributions[0].name ?? "0"))"
                    
                    var wAQIAQI = wAQIData.data?.aqi ?? 0
                    let wAQIAQIColourButton: String
                    switch (wAQIAQI) {
                    case _ where wAQIAQI > 0 && wAQIAQI < 50:
                        wAQIAQIColourButton = "[🟢_____]"
                        self.wAQIAQIColourButton.title = "🟢"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    case _ where wAQIAQI > 51 && wAQIAQI < 100:
                        wAQIAQIColourButton = "[_🟡____]"
                        self.wAQIAQIColourButton.title = "🟡"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    case _ where wAQIAQI > 101 && wAQIAQI < 200:
                        wAQIAQIColourButton = "[__🟠___]"
                        self.wAQIAQIColourButton.title = "🟠"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    case _ where wAQIAQI > 201 && wAQIAQI < 300:
                        wAQIAQIColourButton = "[___🔴__]"
                        self.wAQIAQIColourButton.title = "🔴"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    case _ where wAQIAQI > 301 && wAQIAQI < 400:
                        wAQIAQIColourButton = "[____🟣_]"
                        self.wAQIAQIColourButton.title = "🟣"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    case _ where wAQIAQI > 400:
                        wAQIAQIColourButton = "[_____🟤]"
                        self.wAQIAQIColourButton.title = "🟤"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    default:
                        wAQIAQIColourButton = ""
                        self.wAQIAQIColourButton.title = "⚪"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    }
                    self.wAQIAQI.title = "☁️: \(String(wAQIData.data?.aqi ?? 0)) AQI (US EPA, Current)     \(wAQIAQIColourButton)"
                    
                    self.wAQIDominentPol.title = "🎯: Dominant Pollutant: \(String(wAQIData.data?.dominentpol ?? "0"))"
                    
                    
                    self.wAQITemperature.title = "🌡: \(String(wAQIData.data?.iaqi.t?.v ?? 0))℃"
                    
                    self.wAQITime.title = "📅: Reading Taken: \(String(wAQIData.data?.time.s ?? "0"))"
                    
                }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                self.cO2Country.title = "🌍: Carbon Intensity of Electricity Consumption in \(cO2Data.countryCode ?? "")"
                self.cO2carbonIntensity.title = "🔥: \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.carbonIntensity ?? 0)) \(cO2Data.units?.carbonIntensity ?? "")"
                self.cO2fossilFuelPercentage.title = "🦖: \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.fossilFuelPercentage ?? 0))% fossil fueled"
                
            })
            
            
        }
        
    }
    
}
