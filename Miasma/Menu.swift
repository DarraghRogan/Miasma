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
        self.previousStateForNotificationBefore = "⚪"
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
    
    var cO2FossilFuelMix : NSMenuItem = {
        return NSMenuItem(title: "⚡️: ", action: nil, keyEquivalent: "")
    }()
    
    
    var openSkyAircraftInBox : NSMenuItem = {
        return NSMenuItem(title: "✈️: ", action: nil, keyEquivalent: "")
    }()
    
    
    var climaCellWeather : NSMenuItem = {
        return NSMenuItem(title: "🌦: ", action: nil, keyEquivalent: "")
    }()
    
    var climaCellAirQuality : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()
    
    var climaCellPollen : NSMenuItem = {
        return NSMenuItem(title: "🌳: ", action: nil, keyEquivalent: "")
    }()
    
    var previousStateForNotificationBefore: String
    
    // Define how to open windows & web addresses from menu
    @objc func openPurpleAir(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.purpleair.com/map?opt=1/mAQI/a0/cC0&select=\(AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String())")!)
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
    
    @objc func openClimaCell(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.climacell.co/consumer-app/")!)
    }
    
    @objc func menuRefresh(_ sender: NSMenuItem) {
        
        // Read in current state of AQI from either PA or WAQI to faciliate sending notifications if there are serious climbs detected
        if  AppDelegate().defaults.integer(forKey:"PurpleAirInUse") == 1
        {
            previousStateForNotificationBefore = purpleAirPM2_5StatusBarIcon.title
        }
        if  AppDelegate().defaults.integer(forKey:"WAQIInUse") == 1
        {
            previousStateForNotificationBefore = wAQIAQIColourButton.title
        }

        menu.removeAllItems()
        menuLoadOptionals()
        menuLoadNonOptionals()
    }
    
    @objc func openAboutMiasma(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://miasma.app")!)
    }
    
    @objc func menuReview(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
        
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
            title: "Refresh (automatically every 20 mins)",
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
                    title: "Electricity Consumption (CO₂ Signal)...",
                    action: #selector(menuFunctions.openCO2(_:)),
                    keyEquivalent: "e"
                )
                CO2Link.target = self
                menu.addItem(CO2Link)
                
                menu.addItem(cO2Country)
                menu.addItem(cO2FossilFuelMix)
                
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
            
            if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                
                menu.addItem(NSMenuItem.separator())
                let OpenClimaCell = NSMenuItem(
                    title: "1 Hour Forecast (ClimaCell Nearcast)...",
                    action: #selector(menuFunctions.openClimaCell(_:)),
                    keyEquivalent: "c"
                )
                OpenClimaCell.target = self
                menu.addItem(OpenClimaCell)
                
                menu.addItem(climaCellWeather)
                menu.addItem(climaCellAirQuality)
                menu.addItem(climaCellPollen)
            }
            
            DataLoaderPurpleAir().loadPurpleAirData(id: (AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                    DataLoaderCO2().loadCO2Data(lat: String(purpleAirData.results?[0].lat ?? 0), lon: String(purpleAirData.results?[0].lon ?? 0))
                }
                
                if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: ((purpleAirData.results?[0].lat ?? 0)-1), lomin: ((purpleAirData.results?[0].lon ?? 0)-1), lamax: ((purpleAirData.results?[0].lat ?? 0)+1), lomax: ((purpleAirData.results?[0].lon ?? 0)+1))
                }
                
                if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                    DataLoaderClimaCell().loadClimaCellData(lat: purpleAirData.results?[0].lat ?? 0, lon: purpleAirData.results?[0].lon ?? 0)
                }
                
                self.purpleAirLocation.title = "🌍: \(String(purpleAirData.results?[0].label ?? "0")); Type: \(String(purpleAirData.results?[0].deviceLocationtype ?? "0"))"
                
                // AQI Calc from https://forum.airnowtech.org/t/the-aqi-equation/169
                
                var pM2_5Value = round(Double(purpleAirData.results?[0].pm25Value ?? "") ?? 0)
                let pM2_5ColourButton: String
                let aQI_CalculatedDouble: Double
                var aQI_CalculatedRounded: Int = 0
                switch (pM2_5Value) {
                case _ where pM2_5Value > 0 && pM2_5Value < 12:
                    pM2_5ColourButton = "[🟢_____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟢"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((50-0)/(12-0))*((pM2_5Value)-0)+0
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                case _ where pM2_5Value > 12 && pM2_5Value < 35.5:
                    pM2_5ColourButton = "[_🟡_____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟡"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((100-51)/(35.4-12.1))*((pM2_5Value)-12.1)+51
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if self.previousStateForNotificationBefore == "🟢" && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                    {
                        AppDelegate().showNotification(title: "🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.results?[0].label ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                    }
                    
                case _ where pM2_5Value > 35.5 && pM2_5Value < 55.5:
                    pM2_5ColourButton = "[__🟠____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟠"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((150-101)/(55.4-35.5))*((pM2_5Value)-35.5)+101
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                    {
                        AppDelegate().showNotification(title: "🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.results?[0].label ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                    }
                    
                case _ where pM2_5Value > 55.5 && pM2_5Value < 150.5:
                    pM2_5ColourButton = "[___🔴___]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🔴"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((200-151)/(150.4-55.5))*((pM2_5Value)-55.5)+151
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡" || self.previousStateForNotificationBefore == "🟠") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                    {
                        AppDelegate().showNotification(title: "🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.results?[0].label ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                    }
                    
                case _ where pM2_5Value > 150.5 && pM2_5Value < 250.5:
                    pM2_5ColourButton = "[____🟣__]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟣"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((300-201)/(250.4-150.5))*((pM2_5Value)-150.5)+201
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡" || self.previousStateForNotificationBefore == "🟠" || self.previousStateForNotificationBefore == "🔴") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                    {
                        AppDelegate().showNotification(title: "🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.results?[0].label ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                    }
                    
                case _ where pM2_5Value > 250.5 && pM2_5Value < 500.5:
                    pM2_5ColourButton = "[_____🟤_]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟤"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((500-301)/(500.4-250.5))*((pM2_5Value)-250.5)+301
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡" || self.previousStateForNotificationBefore == "🟠" || self.previousStateForNotificationBefore == "🔴" || self.previousStateForNotificationBefore == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                    {
                        AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.results?[0].label ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                    }
                    
                case _ where pM2_5Value > 500.5:
                    pM2_5ColourButton = "[______🟤]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟤"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedRounded = 500
                    
                    if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡" || self.previousStateForNotificationBefore == "🟠" || self.previousStateForNotificationBefore == "🔴" || self.previousStateForNotificationBefore == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                    {
                        AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.results?[0].label ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                    }
                    
                default:
                    pM2_5ColourButton = ""
                    self.purpleAirPM2_5StatusBarIcon.title = "⚪"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                }
                self.purpleAirPM2_5.title = "☁️: \(String(aQI_CalculatedRounded)) US EPA AQI PM₂.₅ (Current)   \(pM2_5ColourButton)"
                
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
                    self.cO2Country.title = "🌍: Carbon Intensity in \(cO2Data.countryCode ?? ""): \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.carbonIntensity ?? 0))gCO₂eq/kWh"
                    
                    var fossilFuelPercentage = cO2Data.data?.fossilFuelPercentage ?? 0
                    let fossilFuelPercentage_visual: String
                    // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                    switch (fossilFuelPercentage) {
                    case _ where fossilFuelPercentage > 0 && fossilFuelPercentage < 5:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️♻️]"
                    case _ where fossilFuelPercentage > 5 && fossilFuelPercentage < 15:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️🦖]"
                    case _ where fossilFuelPercentage > 15 && fossilFuelPercentage < 25:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️🦖🦖]"
                    case _ where fossilFuelPercentage > 25 && fossilFuelPercentage < 35:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 35 && fossilFuelPercentage < 45:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 45 && fossilFuelPercentage < 55:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 55 && fossilFuelPercentage < 65:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 65 && fossilFuelPercentage < 75:
                        fossilFuelPercentage_visual = "[♻️♻️♻️🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 75 && fossilFuelPercentage < 85:
                        fossilFuelPercentage_visual = "[♻️♻️🦖🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 85 && fossilFuelPercentage < 95:
                        fossilFuelPercentage_visual = "[♻️🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 95:
                        fossilFuelPercentage_visual = "[🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    default:
                        fossilFuelPercentage_visual = ""
                    }
                    
                    self.cO2FossilFuelMix.title = "⚡️: Low / High Carbon Energy mix: \(fossilFuelPercentage_visual)"
                    
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.openSkyAircraftInBox.title = "✈️: \(String(format: "%U", locale: Locale.current, openSkyData.states?.count ?? 0)) aircraft in ±1° latitude/longitude box over Air Quality sensor"
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    
                    var windDirection = climaCellData[0].windDirection?.value ?? 0
                    let windDirection_acronymn: String
                    // directiosn from http://www.angelfire.com/space/one1/cal.html
                    switch (windDirection) {
                    case _ where windDirection < 45:
                        windDirection_acronymn = "NNE"
                    case _ where windDirection > 45 && windDirection < 90:
                        windDirection_acronymn = "ENE"
                    case _ where windDirection > 90 && windDirection < 135:
                        windDirection_acronymn = "ESE"
                    case _ where windDirection > 135 && windDirection < 180:
                        windDirection_acronymn = "SSE"
                    case _ where windDirection > 180 && windDirection < 225:
                        windDirection_acronymn = "SSW"
                    case _ where windDirection > 225 && windDirection < 270:
                        windDirection_acronymn = "WSW"
                    case _ where windDirection > 270 && windDirection < 315:
                        windDirection_acronymn = "WNW"
                    case _ where windDirection > 315:
                        windDirection_acronymn = "NNW"
                    default:
                        windDirection_acronymn = ""
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(climaCellData[0].weatherCode?.value ?? ""), feel like \(String(format: "%.1f", locale: Locale.current, climaCellData[0].feelsLike?.value ?? 0))℃, with wind from \(windDirection_acronymn)° @ \(String(format: "%.1f", locale: Locale.current, climaCellData[0].windSpeed?.value ?? 0))m/s"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(climaCellData[0].epaAqi?.value ?? 0)) US EPA AQI PM₂.₅, with primary pollutant of: \(climaCellData[0].epaPrimaryPollutant?.value ?? "")"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(climaCellData[0].pollenTree?.value ?? 0), Grass: \(climaCellData[0].pollenGrass?.value ?? 0), Weeds: \(climaCellData[0].pollenWeed?.value ?? 0)"
                    
                })
            }
            
        }
        
        
        
        if AppDelegate().defaults.integer(forKey:"WAQIInUse") == 1 {
            
            let WAQILink = NSMenuItem(
                title: "Air Quality (World Air Quality Index)...",
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
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                
                menu.addItem(NSMenuItem.separator())
                let CO2Link = NSMenuItem(
                    title: "Electricity Consumption (CO₂ Signal)...",
                    action: #selector(menuFunctions.openCO2(_:)),
                    keyEquivalent: "e"
                )
                CO2Link.target = self
                menu.addItem(CO2Link)
                
                menu.addItem(cO2Country)
                menu.addItem(cO2FossilFuelMix)
                
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
            
            if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                
                menu.addItem(NSMenuItem.separator())
                let OpenClimaCell = NSMenuItem(
                    title: "1 Hour Forecast (ClimaCell Nearcast)...",
                    action: #selector(menuFunctions.openClimaCell(_:)),
                    keyEquivalent: "c"
                )
                OpenClimaCell.target = self
                menu.addItem(OpenClimaCell)
                
                menu.addItem(climaCellWeather)
                menu.addItem(climaCellAirQuality)
                menu.addItem(climaCellPollen)
            }
            
            DataLoaderWAQI().loadWAQIData(id: (AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                
                if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                    DataLoaderCO2().loadCO2Data(lat: String(wAQIData.data?.city.geo[0] ?? 0), lon: String(wAQIData.data?.city.geo[1] ?? 0))
                }
                
                if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: ((wAQIData.data?.city.geo[0] ?? 0)-1), lomin: ((wAQIData.data?.city.geo[1] ?? 0)-1), lamax: ((wAQIData.data?.city.geo[0] ?? 0)+1), lomax: ((wAQIData.data?.city.geo[1] ?? 0)+1))
                }
                
                if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                    DataLoaderClimaCell().loadClimaCellData(lat: wAQIData.data?.city.geo[0] ?? 0, lon: wAQIData.data?.city.geo[1] ?? 0)
                }
                
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
                        
                        if self.previousStateForNotificationBefore == "🟢" && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                        {
                            AppDelegate().showNotification(title: "🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                        }
                        
                    case _ where wAQIAQI > 101 && wAQIAQI < 200:
                        wAQIAQIColourButton = "[__🟠___]"
                        self.wAQIAQIColourButton.title = "🟠"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                        {
                            AppDelegate().showNotification(title: "🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                        }
                        
                    case _ where wAQIAQI > 201 && wAQIAQI < 300:
                        wAQIAQIColourButton = "[___🔴__]"
                        self.wAQIAQIColourButton.title = "🔴"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡" || self.previousStateForNotificationBefore == "🟠") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                        {
                            AppDelegate().showNotification(title: "🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                        }
                        
                    case _ where wAQIAQI > 301 && wAQIAQI < 400:
                        wAQIAQIColourButton = "[____🟣_]"
                        self.wAQIAQIColourButton.title = "🟣"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡" || self.previousStateForNotificationBefore == "🟠" || self.previousStateForNotificationBefore == "🔴") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                        {
                            AppDelegate().showNotification(title: "🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                        }
                        
                    
                    case _ where wAQIAQI > 400:
                        wAQIAQIColourButton = "[_____🟤]"
                        self.wAQIAQIColourButton.title = "🟤"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if (self.previousStateForNotificationBefore == "🟢" || self.previousStateForNotificationBefore == "🟡" || self.previousStateForNotificationBefore == "🟠" || self.previousStateForNotificationBefore == "🔴" || self.previousStateForNotificationBefore == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1
                        {
                            AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                        }
                        
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
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.cO2Country.title = "🌍: Carbon Intensity in \(cO2Data.countryCode ?? ""): \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.carbonIntensity ?? 0))gCO₂eq/kWh"
                    
                    var fossilFuelPercentage = cO2Data.data?.fossilFuelPercentage ?? 0
                    let fossilFuelPercentage_visual: String
                    // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                    switch (fossilFuelPercentage) {
                    case _ where fossilFuelPercentage > 0 && fossilFuelPercentage < 5:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️♻️]"
                    case _ where fossilFuelPercentage > 5 && fossilFuelPercentage < 15:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️🦖]"
                    case _ where fossilFuelPercentage > 15 && fossilFuelPercentage < 25:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️🦖🦖]"
                    case _ where fossilFuelPercentage > 25 && fossilFuelPercentage < 35:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 35 && fossilFuelPercentage < 45:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 45 && fossilFuelPercentage < 55:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 55 && fossilFuelPercentage < 65:
                        fossilFuelPercentage_visual = "[♻️♻️♻️♻️🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 65 && fossilFuelPercentage < 75:
                        fossilFuelPercentage_visual = "[♻️♻️♻️🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 75 && fossilFuelPercentage < 85:
                        fossilFuelPercentage_visual = "[♻️♻️🦖🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 85 && fossilFuelPercentage < 95:
                        fossilFuelPercentage_visual = "[♻️🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 95:
                        fossilFuelPercentage_visual = "[🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    default:
                        fossilFuelPercentage_visual = ""
                    }
                    
                    self.cO2FossilFuelMix.title = "⚡️: Low / High Carbon Energy mix: \(fossilFuelPercentage_visual)"
                    
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.openSkyAircraftInBox.title = "✈️: \(String(format: "%U", locale: Locale.current, openSkyData.states?.count ?? 0)) aircraft in ±1° latitude/longitude box over Air Quality sensor"
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    
                    var windDirection = climaCellData[0].windDirection?.value ?? 0
                    let windDirection_acronymn: String
                    // directiosn from http://www.angelfire.com/space/one1/cal.html
                    switch (windDirection) {
                    case _ where windDirection < 45:
                        windDirection_acronymn = "NNE"
                    case _ where windDirection > 45 && windDirection < 90:
                        windDirection_acronymn = "ENE"
                    case _ where windDirection > 90 && windDirection < 135:
                        windDirection_acronymn = "ESE"
                    case _ where windDirection > 135 && windDirection < 180:
                        windDirection_acronymn = "SSE"
                    case _ where windDirection > 180 && windDirection < 225:
                        windDirection_acronymn = "SSW"
                    case _ where windDirection > 225 && windDirection < 270:
                        windDirection_acronymn = "WSW"
                    case _ where windDirection > 270 && windDirection < 315:
                        windDirection_acronymn = "WNW"
                    case _ where windDirection > 315:
                        windDirection_acronymn = "NNW"
                    default:
                        windDirection_acronymn = ""
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(climaCellData[0].weatherCode?.value ?? ""), feel like \(String(format: "%.1f", locale: Locale.current, climaCellData[0].feelsLike?.value ?? 0))℃, with wind from \(windDirection_acronymn)° @ \(String(format: "%.1f", locale: Locale.current, climaCellData[0].windSpeed?.value ?? 0))m/s"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(climaCellData[0].epaAqi?.value ?? 0)) US EPA AQI PM₂.₅, with primary pollutant of: \(climaCellData[0].epaPrimaryPollutant?.value ?? "")"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(climaCellData[0].pollenTree?.value ?? 0), Grass: \(climaCellData[0].pollenGrass?.value ?? 0), Weeds: \(climaCellData[0].pollenWeed?.value ?? 0)"
                    
                })
                
            }
        }
        
    }
}
