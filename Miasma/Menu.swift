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
    
    var purpleAirHumidity : NSMenuItem = {
        return NSMenuItem(title: "🌡: ", action: nil, keyEquivalent: "")
    }()
    
    var purpleAirRunningAverages : NSMenuItem = {
        return NSMenuItem(title: "📊: ", action: nil, keyEquivalent: "")
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
    
    
    var smartCitizenLocationType : NSMenuItem = {
        return NSMenuItem(title: "🌍: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenPM2_5 : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenOtherPollutants : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenPhysicalProperties : NSMenuItem = {
        return NSMenuItem(title: "🎤: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizen24HourExposurePM25 : NSMenuItem = {
        return NSMenuItem(title: "📊: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenTemperatureHumidity : NSMenuItem = {
        return NSMenuItem(title: "🌡: / 💧: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenPressure : NSMenuItem = {
        return NSMenuItem(title: "🌬️: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenReadingAge : NSMenuItem = {
        return NSMenuItem(title: "📅: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenPM2_5StatusBarIcon : NSMenuItem = {
        return NSMenuItem(title: "", action: nil, keyEquivalent: "")
    }()
    
    
    
    var cO2Country : NSMenuItem = {
        return NSMenuItem(title: "🌍: ", action: nil, keyEquivalent: "")
    }()
    
    var cO2levelComparedTo100g : NSMenuItem = {
        return NSMenuItem(title: "🔥: ", action: nil, keyEquivalent: "")
    }()
    
    var cO2FossilFuelMix : NSMenuItem = {
        return NSMenuItem(title: "⚡️: ", action: nil, keyEquivalent: "")
    }()
    
    
    var openSkyAircraftInBox : NSMenuItem = {
        return NSMenuItem(title: "✈️: ", action: nil, keyEquivalent: "")
    }()
    
    
    var telraamRoadUsers : NSMenuItem = {
        return NSMenuItem(title: "📊: ", action: nil, keyEquivalent: "")
    }()
    
    var telraamDataTime : NSMenuItem = {
        return NSMenuItem(title: "📅: ", action: nil, keyEquivalent: "")
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
    
    var climaCellSolarGHI : NSMenuItem = {
        return NSMenuItem(title: "☀️: ", action: nil, keyEquivalent: "")
    }()
    
    
    var dailyAtmosphericCO2 : NSMenuItem = {
        return NSMenuItem(title: "⛽: ", action: nil, keyEquivalent: "")
    }()
    
    var globalWarming : NSMenuItem = {
        return NSMenuItem(title: "🌡: ", action: nil, keyEquivalent: "")
    }()
    
    // Define how to open windows & web addresses from menu
    @objc func openPurpleAir(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.purpleair.com/map?opt=1/mAQI/a0/cC0&select=\(AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String())")!)
    }
    
    @objc func openWAQI(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "\(wAQIData.data?.city.url ?? "https://aqicn.org/here/")")!)
    }
    
    @objc func openSmartCitizen(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://smartcitizen.me/kits/\(AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String())")!)
    }
    
    @objc func openCO2(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.electricitymap.org/")!)
    }
    
    @objc func openOpenSky(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://opensky-network.org/")!)
    }
    
    @objc func openTelraam(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.telraam.net/en/location/\(AppDelegate().defaults.object(forKey:"TelraamSegmentID") as? String ?? String())")!)
    }
    
    @objc func openClimaCell(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.climacell.co/weather/")!)
    }
    
    @objc func openClimateChangeStats(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.global-warming.org")!)
    }
    
    @objc func menuRefresh(_ sender: NSMenuItem) {
        
        
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
            title: "Refresh (automatically every \((AppDelegate().defaults.object(forKey:"RefreshIntervalSeconds") as? Double ?? Double())/60) mins)",
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
            menu.addItem(purpleAirHumidity)
            menu.addItem(purpleAirRunningAverages)
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
                menu.addItem(cO2levelComparedTo100g)
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
                    title: "1 Hour Forecast (Tomorrow.io Timeline)...",
                    action: #selector(menuFunctions.openClimaCell(_:)),
                    keyEquivalent: "c"
                )
                OpenClimaCell.target = self
                menu.addItem(OpenClimaCell)
                
                menu.addItem(climaCellWeather)
                menu.addItem(climaCellAirQuality)
                menu.addItem(climaCellPollen)
                menu.addItem(climaCellSolarGHI)
                
            }
            
            DataLoaderPurpleAir().loadPurpleAirData(id: (AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                
                if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                    DataLoaderCO2().loadCO2Data(lat: String(purpleAirData.sensor?.latitude ?? 0), lon: String(purpleAirData.sensor?.longitude ?? 0))
                }
                
                if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: ((purpleAirData.sensor?.latitude ?? 0)-1), lomin: ((purpleAirData.sensor?.longitude ?? 0)-1), lamax: ((purpleAirData.sensor?.latitude ?? 0)+1), lomax: ((purpleAirData.sensor?.longitude ?? 0)+1))
                }
                
                if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                    DataLoaderClimaCell().loadClimaCellData(lat: purpleAirData.sensor?.latitude ?? 0, lon: purpleAirData.sensor?.longitude ?? 0)
                }
                
                self.purpleAirLocation.title = "🌍: \(String(purpleAirData.sensor?.name ?? "0"))"
                
                // AQI Calc from https://forum.airnowtech.org/t/the-aqi-equation/169
                
                var pM2_5Value: Double
                var conversionFactorInUse: String
                
                if AppDelegate().defaults.integer(forKey:"PurpleAirConversionFactorEPAInUse") == 1 {
                    let pM2_5_CF = purpleAirData.sensor?.pm25_cf_1 ?? 0
                    let relativeHumidity = (purpleAirData.sensor?.humidity ?? 0)+4
                    
                    pM2_5Value = round((0.52*pM2_5_CF) - (0.085 * Double(relativeHumidity)) + 5.71)
                    conversionFactorInUse = "🔥"
                } else {
                    pM2_5Value = round(((purpleAirData.sensor?.pm25_A ?? 0) + (purpleAirData.sensor?.pm25_B ?? 0))/2)
                    conversionFactorInUse = ""
                }
                
                let pM2_5ColourButton: String
                let aQI_CalculatedDouble: Double
                var aQI_CalculatedRounded: Int = 0
                switch (pM2_5Value) {
                case _ where pM2_5Value >= 0 && pM2_5Value < 12:
                    pM2_5ColourButton = "[🟢_____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟢"
                    aQI_CalculatedDouble = ((50-0)/(12-0))*((pM2_5Value)-0)+0
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                    }
                    else
                    {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬇ 🟢 Good AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Air quality is considered satisfactory, and air pollution poses little or no risk.")
                    }
                    
                    
                    AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")
                    
                    
                case _ where pM2_5Value >= 12 && pM2_5Value < 35.5:
                    pM2_5ColourButton = "[_🟡_____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟡"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((100-51)/(35.4-12.1))*((pM2_5Value)-12.1)+51
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                    }
                    else
                    {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    }
                    
                    
                    if AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬆ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬇ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                    }
                    
                    AppDelegate().defaults.set("🟡", forKey: "PreviousStateForNotification")
                    
                    
                case _ where pM2_5Value >= 35.5 && pM2_5Value < 55.5:
                    pM2_5ColourButton = "[__🟠____]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟠"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((150-101)/(55.4-35.5))*((pM2_5Value)-35.5)+101
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                    }
                    else
                    {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬆ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬇ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                    }
                    
                    AppDelegate().defaults.set("🟠", forKey: "PreviousStateForNotification")
                    
                    
                case _ where pM2_5Value >= 55.5 && pM2_5Value < 150.5:
                    pM2_5ColourButton = "[___🔴___]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🔴"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((200-151)/(150.4-55.5))*((pM2_5Value)-55.5)+151
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                    }
                    else
                    {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬆ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬇ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                    }
                    
                    AppDelegate().defaults.set(self.purpleAirPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                    
                    
                case _ where pM2_5Value >= 150.5 && pM2_5Value < 250.5:
                    pM2_5ColourButton = "[____🟣__]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟣"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((300-201)/(250.4-150.5))*((pM2_5Value)-150.5)+201
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                    }
                    else
                    {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬆ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬇ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                    }
                    
                    AppDelegate().defaults.set(self.purpleAirPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                    
                    
                case _ where pM2_5Value >= 250.5 && pM2_5Value < 500.5:
                    pM2_5ColourButton = "[_____🟤_]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟤"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedDouble = ((500-301)/(500.4-250.5))*((pM2_5Value)-250.5)+301
                    aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                    
                    if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                    }
                    else
                    {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬆ 🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                    }
                    AppDelegate().defaults.set(self.purpleAirPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                    
                    
                case _ where pM2_5Value >= 500.5:
                    pM2_5ColourButton = "[______🟤]"
                    self.purpleAirPM2_5StatusBarIcon.title = "🟤"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    aQI_CalculatedRounded = 500
                    
                    if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                    }
                    else
                    {
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                    }
                    
                    if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                    {
                        AppDelegate().showNotification(title: "⬆ 🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                    }
                    AppDelegate().defaults.set(self.purpleAirPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                    
                    
                default:
                    pM2_5ColourButton = ""
                    self.purpleAirPM2_5StatusBarIcon.title = "⚪"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                }
                self.purpleAirPM2_5.title = "☁️: \(String(aQI_CalculatedRounded)) US EPA AQI PM₂.₅ / \(String(pM2_5Value)) μg/m³ PM₂.₅ (Current) \(conversionFactorInUse)                       \(pM2_5ColourButton)"
                
                // note including -8F & +4% corrections to temp & RH per: https://www.reddit.com/r/PurpleAir/comments/j14qln/temperature_reported_from_web_map_vs_api_mismatch/
                
                let PurpleAirFahrenheit = (purpleAirData.sensor?.temperature ?? 0)-8
                func calculateCelsius(fahrenheit: Double) -> String {
                    var celsius: Double
                    celsius = (fahrenheit - 32) * 5 / 9
                    let celciusRoundedString = String(format: "%.1f", locale: Locale.current, celsius)
                    return celciusRoundedString
                }
                
                func generatepurpleAirRunningAverages(pm25historical:Double) -> String{
                    
                    let intermediatepM2_5Value: Double
                    var historicalaQI_CalculatedDouble: Double
                    
                    if AppDelegate().defaults.integer(forKey:"PurpleAirConversionFactorEPAInUse") == 1 {
                        let relativeHumidity = (purpleAirData.sensor?.humidity ?? 0)+4
                        
                        intermediatepM2_5Value = round((0.52*pm25historical) - (0.085 * Double(relativeHumidity)) + 5.71)
                        
                    } else {
                        intermediatepM2_5Value = pm25historical
                    }
                    
                    switch (intermediatepM2_5Value) {
                    case _ where intermediatepM2_5Value >= 0 && intermediatepM2_5Value < 12:
                        
                        historicalaQI_CalculatedDouble = ((50-0)/(12-0))*((intermediatepM2_5Value)-0)+0
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            return String(Int(round(historicalaQI_CalculatedDouble)))
                        }
                        else
                        {
                            return "▁"
                        }
                        
                    case _ where intermediatepM2_5Value >= 12 && intermediatepM2_5Value < 35.5:
                        
                        historicalaQI_CalculatedDouble = ((100-51)/(35.4-12.1))*((intermediatepM2_5Value)-12.1)+51
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            return String(Int(round(historicalaQI_CalculatedDouble)))
                        }
                        else
                        {
                            return "▂"
                        }
                        
                    case _ where intermediatepM2_5Value >= 35.5 && intermediatepM2_5Value < 55.5:
                        
                        historicalaQI_CalculatedDouble = ((150-101)/(55.4-35.5))*((intermediatepM2_5Value)-35.5)+101
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            return String(Int(round(historicalaQI_CalculatedDouble)))
                        }
                        else
                        {
                            return "▃"
                        }
                        
                    case _ where intermediatepM2_5Value >= 55.5 && intermediatepM2_5Value < 150.5:
                        
                        historicalaQI_CalculatedDouble = ((200-151)/(150.4-55.5))*((intermediatepM2_5Value)-55.5)+151
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            return String(Int(round(historicalaQI_CalculatedDouble)))
                        }
                        else
                        {
                            return "▅"
                        }
                        
                    case _ where intermediatepM2_5Value >= 150.5 && intermediatepM2_5Value < 250.5:
                        
                        historicalaQI_CalculatedDouble = ((300-201)/(250.4-150.5))*((intermediatepM2_5Value)-150.5)+201
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            return String(Int(round(historicalaQI_CalculatedDouble)))
                        }
                        else
                        {
                            return "▆"
                        }
                        
                    case _ where intermediatepM2_5Value >= 250.5 && intermediatepM2_5Value < 500.5:
                        
                        historicalaQI_CalculatedDouble = ((500-301)/(500.4-250.5))*((intermediatepM2_5Value)-250.5)+301
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            return String(Int(round(historicalaQI_CalculatedDouble)))
                        }
                        else
                        {
                            return "▇"
                        }
                        
                    case _ where intermediatepM2_5Value >= 500.5:
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            return String(500)
                        }
                        else
                        {
                            return "▉"
                        }
                        
                    default:
                        return "◌"
                    }
                    
                    
                }
                
                self.purpleAirRunningAverages.title = "📊: Averages 1w, 24h, 6h, 60m, 30m, 10m, now:       \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_1week ?? 0)) | \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_24hour ?? 0)) | \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_6hour ?? 0)) | \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_60minute ?? 0)) | \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_30minute ?? 0)) | \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_10minute ?? 0)) | \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.pm25_cf_1 ?? 0))"
                
                self.purpleAirHumidity.title = "🌡: \(calculateCelsius(fahrenheit: Double(PurpleAirFahrenheit)))℃ / \(PurpleAirFahrenheit)℉     |    💧: \(String((purpleAirData.sensor?.humidity ?? 0)+4))% Relative Humidity"
                
                var pressureValue = Double(purpleAirData.sensor?.pressure ?? 0) ?? 0
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
                self.purpleAirPressure.title = "🌬️: \(String(purpleAirData.sensor?.pressure ?? 0)) millibar                                                           \(pressure_visual)"
                self.purpleAirReadingAge.title = "⏳: \(String(Int((NSDate().timeIntervalSince1970))-(purpleAirData.sensor?.lastSeen ?? 0))) seconds old at Miasma refresh time"
            })
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.cO2Country.title = "🌍: Carbon Intensity in \(cO2Data.countryCode ?? ""): \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.carbonIntensity ?? 0))gCO₂eq/kWh"
                    
                    if cO2Data.data?.carbonIntensity ?? 100 < 100
                    {
                        self.cO2levelComparedTo100g.title = "🔥: Lower than IEA target of 100gCO₂eq/kWh 👍"
                        
                    }
                    else {
                        var cO2Intensity = cO2Data.data?.carbonIntensity ?? 100
                        let cO2IntensityMultiplier = cO2Intensity/100
                        self.cO2levelComparedTo100g.title = "🔥: \(String(format: "%.1f", locale: Locale.current, cO2IntensityMultiplier)) times the IEA target of 100gCO₂eq/kWh 👎"
                    }
                    
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
                    
                    self.cO2FossilFuelMix.title = "⚡️: Low / High Carbon Energy mix:                 \(fossilFuelPercentage_visual)"
                    
                    
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.openSkyAircraftInBox.title = "✈️: \(String(format: "%U", locale: Locale.current, openSkyData.states?.count ?? 0)) aircraft in ±1° latitude/longitude box over Air Quality sensor"
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    
                    var windDirection = climaCellData.data?.timelines?[0].intervals?[1].values?.windDirection ?? 0
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
                    
                    let ClimaCellCelcius = climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    
                    let ClimaCellWeatherCode = climaCellData.data?.timelines?[0].intervals?[1].values?.weatherCode ?? 0
                    var ClimaCellWeatherCodeText: String
                    switch ClimaCellWeatherCode {
                    case _ where ClimaCellWeatherCode == 1000:
                        ClimaCellWeatherCodeText = "Clear"
                    case _ where ClimaCellWeatherCode == 1001:
                        ClimaCellWeatherCodeText = "Cloudy"
                    case _ where ClimaCellWeatherCode == 1100:
                        ClimaCellWeatherCodeText = "Mostly Clear"
                    case _ where ClimaCellWeatherCode == 1101:
                        ClimaCellWeatherCodeText = "Partly Cloudy"
                    case _ where ClimaCellWeatherCode == 1102:
                        ClimaCellWeatherCodeText = "Mostly Cloudy"
                    case _ where ClimaCellWeatherCode == 2000:
                        ClimaCellWeatherCodeText = "Fog"
                    case _ where ClimaCellWeatherCode == 2100:
                        ClimaCellWeatherCodeText = "Light Fog"
                    case _ where ClimaCellWeatherCode == 3000:
                        ClimaCellWeatherCodeText = "Light Wind"
                    case _ where ClimaCellWeatherCode == 3001:
                        ClimaCellWeatherCodeText = "Wind"
                    case _ where ClimaCellWeatherCode == 3002:
                        ClimaCellWeatherCodeText = "Strong Wind"
                    case _ where ClimaCellWeatherCode == 4000:
                        ClimaCellWeatherCodeText = "Drizzle"
                    case _ where ClimaCellWeatherCode == 4001:
                        ClimaCellWeatherCodeText = "Rain"
                    case _ where ClimaCellWeatherCode == 4200:
                        ClimaCellWeatherCodeText = "Light Rain"
                    case _ where ClimaCellWeatherCode == 4201:
                        ClimaCellWeatherCodeText = "Heavy Rain"
                    case _ where ClimaCellWeatherCode == 5000:
                        ClimaCellWeatherCodeText = "Snow"
                    case _ where ClimaCellWeatherCode == 5001:
                        ClimaCellWeatherCodeText = "Flurries"
                    case _ where ClimaCellWeatherCode == 5100:
                        ClimaCellWeatherCodeText = "Light Snow"
                    case _ where ClimaCellWeatherCode == 5101:
                        ClimaCellWeatherCodeText = "Heavy Snow"
                    case _ where ClimaCellWeatherCode == 6000:
                        ClimaCellWeatherCodeText = "Freezing Drizzle"
                    case _ where ClimaCellWeatherCode == 6001:
                        ClimaCellWeatherCodeText = "Freezing Rain"
                    case _ where ClimaCellWeatherCode == 6200:
                        ClimaCellWeatherCodeText = "Light Freezing Rain"
                    case _ where ClimaCellWeatherCode == 6201:
                        ClimaCellWeatherCodeText = "Heavy Freezing Rain"
                    case _ where ClimaCellWeatherCode == 7000:
                        ClimaCellWeatherCodeText = "Ice Pellets"
                    case _ where ClimaCellWeatherCode == 7101:
                        ClimaCellWeatherCodeText = "Heavy Ice Pellets"
                    case _ where ClimaCellWeatherCode == 7102:
                        ClimaCellWeatherCodeText = "Light Ice Pellets"
                    case _ where ClimaCellWeatherCode == 8000:
                        ClimaCellWeatherCodeText = "Thunderstorm"
                    default:
                        ClimaCellWeatherCodeText = "Unknown"
                    }
                    
                    let ClimaCellPrimaryPollutant = climaCellData.data?.timelines?[0].intervals?[1].values?.epaPrimaryPollutant ?? 0
                    var ClimaCellPrimaryPollutantText: String
                    switch ClimaCellPrimaryPollutant {
                    case _ where ClimaCellPrimaryPollutant == 0:
                        ClimaCellPrimaryPollutantText = "PM₂.₅"
                    case _ where ClimaCellPrimaryPollutant == 1:
                        ClimaCellPrimaryPollutantText = "PM₁₀"
                    case _ where ClimaCellPrimaryPollutant == 2:
                        ClimaCellPrimaryPollutantText = "O₃"
                    case _ where ClimaCellPrimaryPollutant == 3:
                        ClimaCellPrimaryPollutantText = "NO₂"
                    case _ where ClimaCellPrimaryPollutant == 4:
                        ClimaCellPrimaryPollutantText = "CO"
                    case _ where ClimaCellPrimaryPollutant == 5:
                        ClimaCellPrimaryPollutantText = "SO₂"
                    default:
                        ClimaCellPrimaryPollutantText = "Unknown"
                    }
                    
                    
                    var solarGHI = climaCellData.data?.timelines?[0].intervals?[1].values?.solarGHI ?? 0
                    let solarGHI_visual: String
                    // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                    switch (solarGHI) {
                    case _ where solarGHI > 0 && solarGHI < 100:
                        solarGHI_visual = "[☀️🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 100 && solarGHI < 200:
                        solarGHI_visual = "[☀️☀️🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 200 && solarGHI < 300:
                        solarGHI_visual = "[☀️☀️☀️🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 300 && solarGHI < 400:
                        solarGHI_visual = "[☀️☀️☀️☀️🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 400 && solarGHI < 500:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 500 && solarGHI < 600:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 600 && solarGHI < 700:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️🌚🌚🌚🌚]"
                    case _ where solarGHI > 700 && solarGHI < 800:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️🌚🌚🌚]"
                    case _ where solarGHI > 800 && solarGHI < 900:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️🌚🌚]"
                    case _ where solarGHI > 900 && solarGHI < 1000:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️🌚]"
                    case _ where solarGHI > 1000:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️]"
                    default:
                        solarGHI_visual = "[🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(ClimaCellWeatherCodeText), \(String(format: "%.1f", locale: Locale.current, climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0))℃ / \(calculateFahrenheit(celcius: Double(ClimaCellCelcius)))℉ (Apparent), with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)))m/s / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)*3.6))km/h / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)*2.23694))mph"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(Double(climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0))) US EPA AQI PM₂.₅, with primary pollutant of \(ClimaCellPrimaryPollutantText)"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0), Grass: \(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0), Weeds: \(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0)"
                    
                    self.climaCellSolarGHI.title = "☀️: \(climaCellData.data?.timelines?[0].intervals?[1].values?.solarGHI ?? 0)W/m² potential solar generation (GHI)  \(solarGHI_visual)"
                    
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
                menu.addItem(cO2levelComparedTo100g)
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
                    title: "1 Hour Forecast (Tomorrow.io Timeline)...",
                    action: #selector(menuFunctions.openClimaCell(_:)),
                    keyEquivalent: "c"
                )
                OpenClimaCell.target = self
                menu.addItem(OpenClimaCell)
                
                menu.addItem(climaCellWeather)
                menu.addItem(climaCellAirQuality)
                menu.addItem(climaCellPollen)
                menu.addItem(climaCellSolarGHI)
                
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
                    case _ where wAQIAQI >= 0 && wAQIAQI < 50:
                        wAQIAQIColourButton = "[🟢_____]"
                        self.wAQIAQIColourButton.title = "🟢"
                        AppDelegate().defaults.set(self.wAQIAQIColourButton.title, forKey: "PreviousStateForNotification")
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title) \(wAQIAQI)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && wAQIAQI >= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟢 Good AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Air quality is considered satisfactory, and air pollution poses little or no risk.")
                        }
                        
                    case _ where wAQIAQI >= 51 && wAQIAQI < 100:
                        wAQIAQIColourButton = "[_🟡____]"
                        self.wAQIAQIColourButton.title = "🟡"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title) \(wAQIAQI)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        }
                        
                        if AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && wAQIAQI >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            
                            AppDelegate().showNotification(title: "⬆ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && wAQIAQI <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                        }
                        
                        
                        AppDelegate().defaults.set(self.wAQIAQIColourButton.title, forKey: "PreviousStateForNotification")
                        
                        
                    case _ where wAQIAQI >= 101 && wAQIAQI < 200:
                        wAQIAQIColourButton = "[__🟠___]"
                        self.wAQIAQIColourButton.title = "🟠"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title) \(wAQIAQI)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && wAQIAQI >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            
                            AppDelegate().showNotification(title: "⬆ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && wAQIAQI <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                        }
                        
                        AppDelegate().defaults.set(self.wAQIAQIColourButton.title, forKey: "PreviousStateForNotification")
                        
                        
                    case _ where wAQIAQI >= 201 && wAQIAQI < 300:
                        wAQIAQIColourButton = "[___🔴__]"
                        self.wAQIAQIColourButton.title = "🔴"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title) \(wAQIAQI)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && wAQIAQI >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            
                            AppDelegate().showNotification(title: "⬆ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && wAQIAQI <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                        }
                        
                        AppDelegate().defaults.set(self.wAQIAQIColourButton.title, forKey: "PreviousStateForNotification")
                        
                        
                    case _ where wAQIAQI >= 301 && wAQIAQI < 400:
                        wAQIAQIColourButton = "[____🟣_]"
                        self.wAQIAQIColourButton.title = "🟣"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title) \(wAQIAQI)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && wAQIAQI >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            
                            AppDelegate().showNotification(title: "⬆ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && wAQIAQI <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                        }
                        
                        AppDelegate().defaults.set(self.wAQIAQIColourButton.title, forKey: "PreviousStateForNotification")
                        
                        
                        
                    case _ where wAQIAQI >= 400:
                        wAQIAQIColourButton = "[_____🟤]"
                        self.wAQIAQIColourButton.title = "🟤"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title) \(wAQIAQI)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && wAQIAQI >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            
                            AppDelegate().showNotification(title: "⬆ 🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                        }
                        AppDelegate().defaults.set(self.wAQIAQIColourButton.title, forKey: "PreviousStateForNotification")
                        
                        
                    default:
                        wAQIAQIColourButton = ""
                        self.wAQIAQIColourButton.title = "⚪"
                        statusItem.button?.title = "M \(self.wAQIAQIColourButton.title)"
                    }
                    self.wAQIAQI.title = "☁️: \(String(wAQIData.data?.aqi ?? 0)) US EPA AQI PM₂.₅ (Current)                                                   \(wAQIAQIColourButton)"
                    
                    self.wAQIDominentPol.title = "🎯: Dominant Pollutant: \(String(wAQIData.data?.dominentpol ?? "0"))"
                    
                    self.wAQITemperature.title = "🌡: \(String(wAQIData.data?.iaqi.t?.v ?? 0))℃"
                    
                    self.wAQITime.title = "📅: Reading Taken: \(String(wAQIData.data?.time.s ?? "0"))"
                    
                }
            })
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.cO2Country.title = "🌍: Carbon Intensity in \(cO2Data.countryCode ?? ""): \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.carbonIntensity ?? 0))gCO₂eq/kWh"
                    
                    if cO2Data.data?.carbonIntensity ?? 100 < 100
                    {
                        self.cO2levelComparedTo100g.title = "🔥: Lower than IEA target of 100gCO₂eq/kWh 👍"
                        
                    }
                    else {
                        var cO2Intensity = cO2Data.data?.carbonIntensity ?? 100
                        let cO2IntensityMultiplier = cO2Intensity/100
                        self.cO2levelComparedTo100g.title = "🔥: \(String(format: "%.1f", locale: Locale.current, cO2IntensityMultiplier)) times the IEA target of 100gCO₂eq/kWh 👎"
                    }
                    
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
                    
                    self.cO2FossilFuelMix.title = "⚡️: Low / High Carbon Energy mix:               \(fossilFuelPercentage_visual)"
                    
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.openSkyAircraftInBox.title = "✈️: \(String(format: "%U", locale: Locale.current, openSkyData.states?.count ?? 0)) aircraft in ±1° latitude/longitude box over Air Quality sensor"
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    
                    var windDirection = climaCellData.data?.timelines?[0].intervals?[1].values?.windDirection ?? 0
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
                    
                    let ClimaCellCelcius = climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    
                    let ClimaCellWeatherCode = climaCellData.data?.timelines?[0].intervals?[1].values?.weatherCode ?? 0
                    var ClimaCellWeatherCodeText: String
                    switch ClimaCellWeatherCode {
                    case _ where ClimaCellWeatherCode == 1000:
                        ClimaCellWeatherCodeText = "Clear"
                    case _ where ClimaCellWeatherCode == 1001:
                        ClimaCellWeatherCodeText = "Cloudy"
                    case _ where ClimaCellWeatherCode == 1100:
                        ClimaCellWeatherCodeText = "Mostly Clear"
                    case _ where ClimaCellWeatherCode == 1101:
                        ClimaCellWeatherCodeText = "Partly Cloudy"
                    case _ where ClimaCellWeatherCode == 1102:
                        ClimaCellWeatherCodeText = "Mostly Cloudy"
                    case _ where ClimaCellWeatherCode == 2000:
                        ClimaCellWeatherCodeText = "Fog"
                    case _ where ClimaCellWeatherCode == 2100:
                        ClimaCellWeatherCodeText = "Light Fog"
                    case _ where ClimaCellWeatherCode == 3000:
                        ClimaCellWeatherCodeText = "Light Wind"
                    case _ where ClimaCellWeatherCode == 3001:
                        ClimaCellWeatherCodeText = "Wind"
                    case _ where ClimaCellWeatherCode == 3002:
                        ClimaCellWeatherCodeText = "Strong Wind"
                    case _ where ClimaCellWeatherCode == 4000:
                        ClimaCellWeatherCodeText = "Drizzle"
                    case _ where ClimaCellWeatherCode == 4001:
                        ClimaCellWeatherCodeText = "Rain"
                    case _ where ClimaCellWeatherCode == 4200:
                        ClimaCellWeatherCodeText = "Light Rain"
                    case _ where ClimaCellWeatherCode == 4201:
                        ClimaCellWeatherCodeText = "Heavy Rain"
                    case _ where ClimaCellWeatherCode == 5000:
                        ClimaCellWeatherCodeText = "Snow"
                    case _ where ClimaCellWeatherCode == 5001:
                        ClimaCellWeatherCodeText = "Flurries"
                    case _ where ClimaCellWeatherCode == 5100:
                        ClimaCellWeatherCodeText = "Light Snow"
                    case _ where ClimaCellWeatherCode == 5101:
                        ClimaCellWeatherCodeText = "Heavy Snow"
                    case _ where ClimaCellWeatherCode == 6000:
                        ClimaCellWeatherCodeText = "Freezing Drizzle"
                    case _ where ClimaCellWeatherCode == 6001:
                        ClimaCellWeatherCodeText = "Freezing Rain"
                    case _ where ClimaCellWeatherCode == 6200:
                        ClimaCellWeatherCodeText = "Light Freezing Rain"
                    case _ where ClimaCellWeatherCode == 6201:
                        ClimaCellWeatherCodeText = "Heavy Freezing Rain"
                    case _ where ClimaCellWeatherCode == 7000:
                        ClimaCellWeatherCodeText = "Ice Pellets"
                    case _ where ClimaCellWeatherCode == 7101:
                        ClimaCellWeatherCodeText = "Heavy Ice Pellets"
                    case _ where ClimaCellWeatherCode == 7102:
                        ClimaCellWeatherCodeText = "Light Ice Pellets"
                    case _ where ClimaCellWeatherCode == 8000:
                        ClimaCellWeatherCodeText = "Thunderstorm"
                    default:
                        ClimaCellWeatherCodeText = "Unknown"
                    }
                    
                    let ClimaCellPrimaryPollutant = climaCellData.data?.timelines?[0].intervals?[1].values?.epaPrimaryPollutant ?? 0
                    var ClimaCellPrimaryPollutantText: String
                    switch ClimaCellPrimaryPollutant {
                    case _ where ClimaCellPrimaryPollutant == 0:
                        ClimaCellPrimaryPollutantText = "PM₂.₅"
                    case _ where ClimaCellPrimaryPollutant == 1:
                        ClimaCellPrimaryPollutantText = "PM₁₀"
                    case _ where ClimaCellPrimaryPollutant == 2:
                        ClimaCellPrimaryPollutantText = "O₃"
                    case _ where ClimaCellPrimaryPollutant == 3:
                        ClimaCellPrimaryPollutantText = "NO₂"
                    case _ where ClimaCellPrimaryPollutant == 4:
                        ClimaCellPrimaryPollutantText = "CO"
                    case _ where ClimaCellPrimaryPollutant == 5:
                        ClimaCellPrimaryPollutantText = "SO₂"
                    default:
                        ClimaCellPrimaryPollutantText = "Unknown"
                    }
                    
                    
                    var solarGHI = climaCellData.data?.timelines?[0].intervals?[1].values?.solarGHI ?? 0
                    let solarGHI_visual: String
                    // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                    switch (solarGHI) {
                    case _ where solarGHI > 0 && solarGHI < 100:
                        solarGHI_visual = "[☀️🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 100 && solarGHI < 200:
                        solarGHI_visual = "[☀️☀️🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 200 && solarGHI < 300:
                        solarGHI_visual = "[☀️☀️☀️🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 300 && solarGHI < 400:
                        solarGHI_visual = "[☀️☀️☀️☀️🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 400 && solarGHI < 500:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 500 && solarGHI < 600:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 600 && solarGHI < 700:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️🌚🌚🌚🌚]"
                    case _ where solarGHI > 700 && solarGHI < 800:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️🌚🌚🌚]"
                    case _ where solarGHI > 800 && solarGHI < 900:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️🌚🌚]"
                    case _ where solarGHI > 900 && solarGHI < 1000:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️🌚]"
                    case _ where solarGHI > 1000:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️]"
                    default:
                        solarGHI_visual = "[🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(ClimaCellWeatherCodeText), \(String(format: "%.1f", locale: Locale.current, climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0))℃ / \(calculateFahrenheit(celcius: Double(ClimaCellCelcius)))℉ (Apparent), with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)))m/s / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)*3.6))km/h / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)*2.23694))mph"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(Double(climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0))) US EPA AQI PM₂.₅, with primary pollutant of \(ClimaCellPrimaryPollutantText)"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0), Grass: \(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0), Weeds: \(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0)"
                    
                    self.climaCellSolarGHI.title = "☀️: \(climaCellData.data?.timelines?[0].intervals?[1].values?.solarGHI ?? 0)W/m² potential solar generation (GHI)   \(solarGHI_visual)"
                    
                })
                
            }
        }
        
        
        
        if AppDelegate().defaults.integer(forKey:"SmartCitizenInUse") == 1 {
            
            let SmartCitizenLink = NSMenuItem(
                title: "Air Quality (SmartCitizen)...",
                action: #selector(menuFunctions.openSmartCitizen(_:)),
                keyEquivalent: "s"
            )
            SmartCitizenLink.target = self
            menu.addItem(SmartCitizenLink)
            
            menu.addItem(smartCitizenLocationType)
            menu.addItem(smartCitizenPM2_5)
            menu.addItem(smartCitizen24HourExposurePM25)
            menu.addItem(smartCitizenOtherPollutants)
            menu.addItem(smartCitizenTemperatureHumidity)
            menu.addItem(smartCitizenPressure)
            menu.addItem(smartCitizenPhysicalProperties)
            //            menu.addItem(smartCitizenReadingAge)
            
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
                menu.addItem(cO2levelComparedTo100g)
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
                    title: "1 Hour Forecast (Tomorrow.io Timeline)...",
                    action: #selector(menuFunctions.openClimaCell(_:)),
                    keyEquivalent: "c"
                )
                OpenClimaCell.target = self
                menu.addItem(OpenClimaCell)
                
                menu.addItem(climaCellWeather)
                menu.addItem(climaCellAirQuality)
                menu.addItem(climaCellPollen)
                menu.addItem(climaCellSolarGHI)
            }
            
            DataLoaderSmartCitizen().loadSmartCitizenPresentData(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            
            DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            
            if AppDelegate().defaults.integer(forKey:"ClimateChangeInUse") == 1 {
                
                menu.addItem(NSMenuItem.separator())
                let ClimateChange = NSMenuItem(
                    title: "Climate Change stats (US NOAA, NASA)...",
                    action: #selector(menuFunctions.openClimateChangeStats(_:)),
                    keyEquivalent: "g"
                )
                ClimateChange.target = self
                menu.addItem(ClimateChange)
                
                menu.addItem(dailyAtmosphericCO2)
                menu.addItem(globalWarming)
                
                DataLoaderDailyAtmosphericCO2().loadDailyAtmosphericCO2Data()
                
                DataLoaderGlobalWarming().loadGlobalWarmingData()
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                    DataLoaderCO2().loadCO2Data(lat: String(smartCitizenPresentData.data?.location?.latitude ?? 0), lon: String(smartCitizenPresentData.data?.location?.longitude ?? 0))
                }
                
                if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: ((smartCitizenPresentData.data?.location?.latitude ?? 0)-1), lomin: ((smartCitizenPresentData.data?.location?.longitude ?? 0)-1), lamax: ((smartCitizenPresentData.data?.location?.latitude ?? 0)+1), lomax: ((smartCitizenPresentData.data?.location?.longitude ?? 0)+1))
                }
                
                if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                    DataLoaderClimaCell().loadClimaCellData(lat: smartCitizenPresentData.data?.location?.latitude ?? 0, lon: smartCitizenPresentData.data?.location?.longitude ?? 0)
                }
                
                if AppDelegate().defaults.integer(forKey:"ClimateChangeInUse") == 1 {
                    
                    if let lastElement = dailyAtmosphericCO2Data.co2?.last?.cycle {
                        
                        let dailyAtmosphericCO2DataArraySize = dailyAtmosphericCO2Data.co2?.count ?? 0
                        
                        let dailyAtmosphericCO2DataArray365DaysAgo = dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-365]
                        let dailyAtmosphericCO2Data365DaysAgo = dailyAtmosphericCO2DataArray365DaysAgo?.trend ?? "0"
                        let cO2PPMAnnualDelta = ((dailyAtmosphericCO2Data.co2?.last?.trend ?? "0") as NSString).doubleValue - (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue
                        let cO2PPMAnnualDeltaPercentage = (cO2PPMAnnualDelta / (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue) * 100
                        
                        let dailyAtmosphericCO2DataArray10YearsAgo = dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-3650]
                        let dailyAtmosphericCO2Data10YearsAgo = dailyAtmosphericCO2DataArray10YearsAgo?.trend ?? "0"
                        let cO2PPMDecadeDelta = ((dailyAtmosphericCO2Data.co2?.last?.trend ?? "0") as NSString).doubleValue - (dailyAtmosphericCO2Data10YearsAgo as NSString).doubleValue
                        let cO2PPMDecadeDeltaPercentage = (cO2PPMDecadeDelta / (dailyAtmosphericCO2Data10YearsAgo as NSString).doubleValue) * 100
                        
                        self.dailyAtmosphericCO2.title = "⛽: \(String(dailyAtmosphericCO2Data.co2?.last?.trend ?? "0"))ppm CO2 (Trend), \(String(format: "%.2f", locale: Locale.current, cO2PPMAnnualDeltaPercentage))% (Annual Δ), \(String(format: "%.2f", locale: Locale.current, cO2PPMDecadeDeltaPercentage))% (Decade Δ)"
                    }
                    
                    self.globalWarming.title = "🌡: \(String(globalWarmingData.result?.last?.land ?? "0.00"))℃, \(String(globalWarmingData.result?.last?.time ?? "0")) Monthly mean surface temp. anomaly vs. 1951-1980"
                    
                }
                
                if 1 == 1 {
                    
                    self.smartCitizenLocationType.title = "🌍: \(String(smartCitizenPresentData.data?.location?.city ?? "0")), \(String(smartCitizenPresentData.data?.location?.country ?? "0")) / Exposure: \(String(smartCitizenPresentData.data?.location?.exposure ?? "0"))"
                    
                    
                    
                    // AQI Calc from https://forum.airnowtech.org/t/the-aqi-equation/169
                    
                    var pM2_5Value = round(smartCitizenPresentData.data?.sensors?[8].value ?? 0)
                    let pM2_5ColourButton: String
                    let aQI_CalculatedDouble: Double
                    var aQI_CalculatedRounded: Int = 0
                    switch (pM2_5Value) {
                    case _ where pM2_5Value >= 0 && pM2_5Value < 12:
                        pM2_5ColourButton = "[🟢_____]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🟢"
                        aQI_CalculatedDouble = ((50-0)/(12-0))*((pM2_5Value)-0)+0
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟢 Good AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Air quality is considered satisfactory, and air pollution poses little or no risk.")
                        }
                        
                        AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")
                        
                        
                    case _ where pM2_5Value >= 12 && pM2_5Value < 35.5:
                        pM2_5ColourButton = "[_🟡_____]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🟡"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((100-51)/(35.4-12.1))*((pM2_5Value)-12.1)+51
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        }
                        
                        
                        if AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                        }
                        
                        AppDelegate().defaults.set("🟡", forKey: "PreviousStateForNotification")
                        
                        
                    case _ where pM2_5Value >= 35.5 && pM2_5Value < 55.5:
                        pM2_5ColourButton = "[__🟠____]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🟠"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((150-101)/(55.4-35.5))*((pM2_5Value)-35.5)+101
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                        }
                        
                        AppDelegate().defaults.set("🟠", forKey: "PreviousStateForNotification")
                        
                        
                    case _ where pM2_5Value >= 55.5 && pM2_5Value < 150.5:
                        pM2_5ColourButton = "[___🔴___]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🔴"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((200-151)/(150.4-55.5))*((pM2_5Value)-55.5)+151
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                        }
                        
                        AppDelegate().defaults.set(self.smartCitizenPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                        
                        
                    case _ where pM2_5Value >= 150.5 && pM2_5Value < 250.5:
                        pM2_5ColourButton = "[____🟣__]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🟣"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((300-201)/(250.4-150.5))*((pM2_5Value)-150.5)+201
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                        }
                        
                        AppDelegate().defaults.set(self.smartCitizenPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                        
                        
                    case _ where pM2_5Value >= 250.5 && pM2_5Value < 500.5:
                        pM2_5ColourButton = "[_____🟤_]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🟤"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((500-301)/(500.4-250.5))*((pM2_5Value)-250.5)+301
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                        }
                        AppDelegate().defaults.set(self.smartCitizenPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                        
                        
                    case _ where pM2_5Value >= 500.5:
                        pM2_5ColourButton = "[______🟤]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🟤"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        aQI_CalculatedRounded = 500
                        
                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                        }
                        
                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenPresentData.data?.location?.city ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                        }
                        AppDelegate().defaults.set(self.smartCitizenPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                        
                        
                    default:
                        pM2_5ColourButton = ""
                        self.smartCitizenPM2_5StatusBarIcon.title = "⚪"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                    }
                    self.smartCitizenPM2_5.title = "☁️: \(String(aQI_CalculatedRounded)) US EPA AQI PM₂.₅ / \(String(smartCitizenPresentData.data?.sensors?[8].value ?? 0)) μg/m³ PM₂.₅ (Current)                         \(pM2_5ColourButton)"
                    
                    var outputpm25historicalStringToday: String = ""
                    var outputpm25historicalString1d: String = ""
                    var outputpm25historicalString2d: String = ""
                    var outputpm25historicalString3d: String = ""
                    var outputpm25historicalString4d: String = ""
                    var outputpm25historicalString5d: String = ""
                    var outputpm25historicalString6d: String = ""
                    var outputpm25historicalString7d: String = ""
                    
                    if let pm25historicalStringToday = smartCitizenHistoricalData.readings?[0][1]
                    {
                         outputpm25historicalStringToday = String("\(pm25historicalStringToday)")
                    }
                    
                    if let pm25historicalString1d = smartCitizenHistoricalData.readings?[1][1]
                    {
                         outputpm25historicalString1d = String("\(pm25historicalString1d)")
                    }
                    
                    if let pm25historicalString2d = smartCitizenHistoricalData.readings?[2][1]
                    {
                         outputpm25historicalString2d = String("\(pm25historicalString2d)")
                    }
                    
                    if let pm25historicalString3d = smartCitizenHistoricalData.readings?[3][1]
                    {
                         outputpm25historicalString3d = String("\(pm25historicalString3d)")
                    }
                    
                    if let pm25historicalString4d = smartCitizenHistoricalData.readings?[4][1]
                    {
                         outputpm25historicalString4d = String("\(pm25historicalString4d)")
                    }
                    
                    if let pm25historicalString5d = smartCitizenHistoricalData.readings?[5][1]
                    {
                         outputpm25historicalString5d = String("\(pm25historicalString5d)")
                    }
                    
                    if let pm25historicalString6d = smartCitizenHistoricalData.readings?[6][1]
                    {
                         outputpm25historicalString6d = String("\(pm25historicalString6d)")
                    }
                    
                    if let pm25historicalString7d = smartCitizenHistoricalData.readings?[7][1]
                    {
                         outputpm25historicalString7d = String("\(pm25historicalString7d)")
                    }
                    
                    self.smartCitizen24HourExposurePM25.title = "📊: Average -7d | -6d | -5d | -4d | -3d | -2d | -1d | today: \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalString7d ?? "")) | \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalString6d ?? "")) | \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalString5d ?? "")) | \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalString4d ?? "")) | \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalString3d ?? "")) | \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalString2d ?? "")) | \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalString1d ?? "")) | \(generatesmartCitizen24HourAverages(pm25historicalString:outputpm25historicalStringToday))"
                    
                                        
                    func generatesmartCitizen24HourAverages(pm25historicalString:String) -> Int{
                        
                        let step1 = pm25historicalString.replacingOccurrences(of: "[^\\.\\d+]", with: "", options: [.regularExpression])
                        
                        print(step1)
                        
                        let step2 = NumberFormatter().number(from: step1)?.doubleValue
                        
                        print(step2)
                        
                        let step3:Int = Int(round(step2 ?? 0.0))
                        
                        print(step3)
                        
                        return step3
                    }

                    
                    self.smartCitizenOtherPollutants.title = "☁️: VOC \(String(smartCitizenPresentData.data?.sensors?[0].value ?? 0))\(String(smartCitizenPresentData.data?.sensors?[0].unit ?? "0")) / CO₂ \(String(smartCitizenPresentData.data?.sensors?[1].value ?? 0))\(String(smartCitizenPresentData.data?.sensors?[1].unit ?? "0"))"
                    
                    //                    self.smartCitizen24HourExposurePM25.title = "📊: \(String(smartCitizenHistoricalData.readings?[0][0].self ?? 0))"
                    
                    self.smartCitizenTemperatureHumidity.title = "🌡: \(String(smartCitizenPresentData.data?.sensors?[10].value ?? 0))℃  /  💧: \(String(smartCitizenPresentData.data?.sensors?[9].value ?? 0))%"
                    
                    var pressureValue = smartCitizenPresentData.data?.sensors?[5].value ?? 0
                    let pressure_visual: String
                    // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                    switch (pressureValue) {
                    case _ where pressureValue < 100.9144:
                        pressure_visual = "[Low/______/____]"
                    case _ where pressureValue > 100.9144 && pressureValue < 102.2689:
                        pressure_visual = "[___/Normal/____]"
                    case _ where pressureValue > 102.2689:
                        pressure_visual = "[___/______/High]"
                    default:
                        pressure_visual = ""
                    }
                    self.smartCitizenPressure.title = "🌬️: \(String(smartCitizenPresentData.data?.sensors?[5].value ?? 0))kilopascal                                                                   \(pressure_visual)"
                    
                    
                    
                    self.smartCitizenPhysicalProperties.title = "🎤: Noise \(String(smartCitizenPresentData.data?.sensors?[4].value ?? 0))\(String(smartCitizenPresentData.data?.sensors?[4].unit ?? "0")) / Ambient Light \(String(smartCitizenPresentData.data?.sensors?[2].value ?? 0))\(String(smartCitizenPresentData.data?.sensors?[2].unit ?? "0"))"
                    
                    //                    self.smartCitizenReadingAge.title = "📅: \(String(smartCitizenData.lastReadingAt?. ?? 0))"
                    
                }
            })
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.cO2Country.title = "🌍: Carbon Intensity in \(cO2Data.countryCode ?? ""): \(String(format: "%.1f", locale: Locale.current, cO2Data.data?.carbonIntensity ?? 0))gCO₂eq/kWh"
                    
                    if cO2Data.data?.carbonIntensity ?? 100 < 100
                    {
                        self.cO2levelComparedTo100g.title = "🔥: Lower than IEA target of 100gCO₂eq/kWh 👍"
                        
                    }
                    else {
                        var cO2Intensity = cO2Data.data?.carbonIntensity ?? 100
                        let cO2IntensityMultiplier = cO2Intensity/100
                        self.cO2levelComparedTo100g.title = "🔥: \(String(format: "%.1f", locale: Locale.current, cO2IntensityMultiplier)) times the IEA target of 100gCO₂eq/kWh 👎"
                    }
                    
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
                    
                    self.cO2FossilFuelMix.title = "⚡️: Low / High Carbon Energy mix:               \(fossilFuelPercentage_visual)"
                    
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    self.openSkyAircraftInBox.title = "✈️: \(String(format: "%U", locale: Locale.current, openSkyData.states?.count ?? 0)) aircraft in ±1° latitude/longitude box over Air Quality sensor"
                })
            }
            
            if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
                    
                    var windDirection = climaCellData.data?.timelines?[0].intervals?[1].values?.windDirection ?? 0
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
                    
                    let ClimaCellCelcius = climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    
                    let ClimaCellWeatherCode = climaCellData.data?.timelines?[0].intervals?[1].values?.weatherCode ?? 0
                    var ClimaCellWeatherCodeText: String
                    switch ClimaCellWeatherCode {
                    case _ where ClimaCellWeatherCode == 1000:
                        ClimaCellWeatherCodeText = "Clear"
                    case _ where ClimaCellWeatherCode == 1001:
                        ClimaCellWeatherCodeText = "Cloudy"
                    case _ where ClimaCellWeatherCode == 1100:
                        ClimaCellWeatherCodeText = "Mostly Clear"
                    case _ where ClimaCellWeatherCode == 1101:
                        ClimaCellWeatherCodeText = "Partly Cloudy"
                    case _ where ClimaCellWeatherCode == 1102:
                        ClimaCellWeatherCodeText = "Mostly Cloudy"
                    case _ where ClimaCellWeatherCode == 2000:
                        ClimaCellWeatherCodeText = "Fog"
                    case _ where ClimaCellWeatherCode == 2100:
                        ClimaCellWeatherCodeText = "Light Fog"
                    case _ where ClimaCellWeatherCode == 3000:
                        ClimaCellWeatherCodeText = "Light Wind"
                    case _ where ClimaCellWeatherCode == 3001:
                        ClimaCellWeatherCodeText = "Wind"
                    case _ where ClimaCellWeatherCode == 3002:
                        ClimaCellWeatherCodeText = "Strong Wind"
                    case _ where ClimaCellWeatherCode == 4000:
                        ClimaCellWeatherCodeText = "Drizzle"
                    case _ where ClimaCellWeatherCode == 4001:
                        ClimaCellWeatherCodeText = "Rain"
                    case _ where ClimaCellWeatherCode == 4200:
                        ClimaCellWeatherCodeText = "Light Rain"
                    case _ where ClimaCellWeatherCode == 4201:
                        ClimaCellWeatherCodeText = "Heavy Rain"
                    case _ where ClimaCellWeatherCode == 5000:
                        ClimaCellWeatherCodeText = "Snow"
                    case _ where ClimaCellWeatherCode == 5001:
                        ClimaCellWeatherCodeText = "Flurries"
                    case _ where ClimaCellWeatherCode == 5100:
                        ClimaCellWeatherCodeText = "Light Snow"
                    case _ where ClimaCellWeatherCode == 5101:
                        ClimaCellWeatherCodeText = "Heavy Snow"
                    case _ where ClimaCellWeatherCode == 6000:
                        ClimaCellWeatherCodeText = "Freezing Drizzle"
                    case _ where ClimaCellWeatherCode == 6001:
                        ClimaCellWeatherCodeText = "Freezing Rain"
                    case _ where ClimaCellWeatherCode == 6200:
                        ClimaCellWeatherCodeText = "Light Freezing Rain"
                    case _ where ClimaCellWeatherCode == 6201:
                        ClimaCellWeatherCodeText = "Heavy Freezing Rain"
                    case _ where ClimaCellWeatherCode == 7000:
                        ClimaCellWeatherCodeText = "Ice Pellets"
                    case _ where ClimaCellWeatherCode == 7101:
                        ClimaCellWeatherCodeText = "Heavy Ice Pellets"
                    case _ where ClimaCellWeatherCode == 7102:
                        ClimaCellWeatherCodeText = "Light Ice Pellets"
                    case _ where ClimaCellWeatherCode == 8000:
                        ClimaCellWeatherCodeText = "Thunderstorm"
                    default:
                        ClimaCellWeatherCodeText = "Unknown"
                    }
                    
                    let ClimaCellPrimaryPollutant = climaCellData.data?.timelines?[0].intervals?[1].values?.epaPrimaryPollutant ?? 0
                    var ClimaCellPrimaryPollutantText: String
                    switch ClimaCellPrimaryPollutant {
                    case _ where ClimaCellPrimaryPollutant == 0:
                        ClimaCellPrimaryPollutantText = "PM₂.₅"
                    case _ where ClimaCellPrimaryPollutant == 1:
                        ClimaCellPrimaryPollutantText = "PM₁₀"
                    case _ where ClimaCellPrimaryPollutant == 2:
                        ClimaCellPrimaryPollutantText = "O₃"
                    case _ where ClimaCellPrimaryPollutant == 3:
                        ClimaCellPrimaryPollutantText = "NO₂"
                    case _ where ClimaCellPrimaryPollutant == 4:
                        ClimaCellPrimaryPollutantText = "CO"
                    case _ where ClimaCellPrimaryPollutant == 5:
                        ClimaCellPrimaryPollutantText = "SO₂"
                    default:
                        ClimaCellPrimaryPollutantText = "Unknown"
                    }
                    
                    var solarGHI = climaCellData.data?.timelines?[0].intervals?[1].values?.solarGHI ?? 0
                    let solarGHI_visual: String
                    // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                    switch (solarGHI) {
                    case _ where solarGHI > 0 && solarGHI < 100:
                        solarGHI_visual = "[☀️🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 100 && solarGHI < 200:
                        solarGHI_visual = "[☀️☀️🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 200 && solarGHI < 300:
                        solarGHI_visual = "[☀️☀️☀️🌚🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 300 && solarGHI < 400:
                        solarGHI_visual = "[☀️☀️☀️☀️🌚🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 400 && solarGHI < 500:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️🌚🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 500 && solarGHI < 600:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️🌚🌚🌚🌚🌚]"
                    case _ where solarGHI > 600 && solarGHI < 700:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️🌚🌚🌚🌚]"
                    case _ where solarGHI > 700 && solarGHI < 800:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️🌚🌚🌚]"
                    case _ where solarGHI > 800 && solarGHI < 900:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️🌚🌚]"
                    case _ where solarGHI > 900 && solarGHI < 1000:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️🌚]"
                    case _ where solarGHI > 1000:
                        solarGHI_visual = "[☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️]"
                    default:
                        solarGHI_visual = "[🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚🌚]"
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(ClimaCellWeatherCodeText), \(String(format: "%.1f", locale: Locale.current, climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0))℃ / \(calculateFahrenheit(celcius: Double(ClimaCellCelcius)))℉ (Apparent), with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)))m/s / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)*3.6))km/h / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0)*2.23694))mph"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(Double(climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0))) US EPA AQI PM₂.₅, with primary pollutant of \(ClimaCellPrimaryPollutantText)"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0), Grass: \(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0), Weeds: \(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0)"
                    
                    self.climaCellSolarGHI.title = "☀️: \(climaCellData.data?.timelines?[0].intervals?[1].values?.solarGHI ?? 0)W/m² potential solar generation (GHI)   \(solarGHI_visual)"
                    
                })
                
            }
        }
        
        if AppDelegate().defaults.integer(forKey:"TelraamInUse") == 1 {
            
            menu.addItem(NSMenuItem.separator())
            
            let telraam = NSMenuItem(
                title: "Road Traffic in previous full hour (daylight only) (Telraam)...",
                action: #selector(menuFunctions.openTelraam(_:)),
                keyEquivalent: "t"
            )
            telraam.target = self
            menu.addItem(telraam)
            
            menu.addItem(telraamRoadUsers)
            menu.addItem(telraamDataTime)
            
            DataLoaderTelraam().loadTelraamData(segmentID:(AppDelegate().defaults.object(forKey:"TelraamSegmentID") as? String ?? String()))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if telraamData.features?.count ?? 0 > 0 {
                    
                    self.telraamRoadUsers.title = "📊: 🚶: \(String(Int(round(telraamData.features?[0].properties?.pedestrian ?? 0)))), 🚲: \(String(Int(round(telraamData.features?[0].properties?.bike ?? 0)))), 🚗: \(String(Int(round(telraamData.features?[0].properties?.car ?? 0)))), 🚚: \(String(Int(round(telraamData.features?[0].properties?.lorry ?? 0))))"
                    
                    self.telraamDataTime.title = "📅: Data Recorded: \(telraamData.features?[0].properties?.lastDataPackage ?? "")"
                    
                    //                    print(telraamData.features?[0].properties?.car)
                    
                } else {
                    self.telraamRoadUsers.title = "Error. Check Telraam Connectivity"
                    self.telraamDataTime.title = "Error. Check Telraam Connectivity"
                }
                
                
                
                //                }
            })
            
        }
    }
}
