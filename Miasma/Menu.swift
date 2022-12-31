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
    
    
    
    
    
    
    var sensorCommunityLocationType : NSMenuItem = {
        return NSMenuItem(title: "🌍: ", action: nil, keyEquivalent: "")
    }()
    
    var sensorCommunityPM2_5 : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()
    
    var sensorCommunityPM10 : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()

    var sensorCommunityReadingAge : NSMenuItem = {
        return NSMenuItem(title: "📅: ", action: nil, keyEquivalent: "")
    }()
    
    var sensorCommunityPM2_5StatusBarIcon : NSMenuItem = {
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
    
    var trendAtmosphericCO2 : NSMenuItem = {
        return NSMenuItem(title: "📈: ", action: nil, keyEquivalent: "")
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
    
    @objc func openSensorCommunity(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://maps.sensor.community/grafana/d/000000004/single-sensor-view-for-map?orgId=1&var-node=\(AppDelegate().defaults.object(forKey:"SensorCommunityStationID") as? String ?? String())")!)
    }
    
    @objc func openCO2(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://app.electricitymap.org/map")!)
    }
    
    @objc func openOpenSky(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://opensky-network.org/")!)
    }
    
    @objc func openTelraam(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.telraam.net/en/location/\(AppDelegate().defaults.object(forKey:"TelraamSegmentID") as? String ?? String())")!)
    }
    
    @objc func openClimaCell(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.tomorrow.io/weather/")!)
    }
    
    @objc func openClimateChangeStats(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.global-warming.org")!)
    }
    
    @objc func openWHOAirQualityGuidelines(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.who.int/publications/i/item/9789240034228?ua=1")!)
    }
    
    @objc func openUNEPEG2019(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.unep.org/resources/emissions-gap-report-2019")!)
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
            title: "Refresh (automatically every \(Int((AppDelegate().defaults.object(forKey:"RefreshIntervalSeconds") as? Double ?? Double())/60)) mins)",
            action: #selector(menuFunctions.menuRefresh(_:)),
            keyEquivalent: "r"
        )
        menuRefresh.target = self
        menu.addItem(menuRefresh)
        
        let wHOAirQualityGuidelines = NSMenuItem(
            title: "WHO Global Air Quality Guidelines <- Best ✓ ④ ③ ② ① ⓪ Worst -> ...",
            action: #selector(menuFunctions.openWHOAirQualityGuidelines(_:)),
            keyEquivalent: "w"
        )
        wHOAirQualityGuidelines.target = self
        menu.addItem(wHOAirQualityGuidelines)
        
        let uNEPEmissionsGap = NSMenuItem(
            title: "UNEP Emissions Gap for 2030 (<-7.6% Avg. Annual CO₂ to limit to 1.5℃, <-2.7% for 2℃)...",
            action: #selector(menuFunctions.openUNEPEG2019(_:)),
            keyEquivalent: "u"
        )
        uNEPEmissionsGap.target = self
        menu.addItem(uNEPEmissionsGap)
        
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
                    title: "Electricity Consumption (electricityMap)...",
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
                    aQI_CalculatedDouble = ((49)/(19.9))*((pM2_5Value)-35.5)+101
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
                    aQI_CalculatedDouble = ((49)/(94.9))*((pM2_5Value)-55.5)+151
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
                    aQI_CalculatedDouble = ((99)/(99.9))*((pM2_5Value)-150.5)+201
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
                    aQI_CalculatedDouble = ((199)/(249.9))*((pM2_5Value)-250.5)+301
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
                
                func generatePurepleAir24HourAverageWHO(pm25historical:Double) -> String{
                    
                    switch (pm25historical) {
                        
                    case _ where pm25historical >= 0 && pm25historical < 15:
                        return String("✓")
                        
                    case _ where pm25historical >= 15 && pm25historical < 25:
                        return String("④")
                        
                    case _ where pm25historical >= 25 && pm25historical < 37.5:
                        return String("③")
                        
                    case _ where pm25historical >= 37.5 && pm25historical < 50:
                        return String("②")
                        
                    case _ where pm25historical >= 50 && pm25historical < 75:
                        return String("①")
                        
                    case _ where pm25historical >= 75:
                        return String("⓪")
                        
                    default:
                        return String("")
                        
                    }
                    
                }
                
                self.purpleAirRunningAverages.title = "📊: Average AQI:   1w: \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_1week ?? 0)) \(generatePurepleAir24HourAverageWHO(pm25historical:purpleAirData.sensor?.stats?.pm25_1week ?? 0)) | 1d: \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_24hour ?? 0)) \(generatePurepleAir24HourAverageWHO(pm25historical:purpleAirData.sensor?.stats?.pm25_24hour ?? 0)) | 6h: \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_6hour ?? 0)) | 60m: \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_60minute ?? 0)) | 30m: \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_30minute ?? 0)) | 10m: \(generatepurpleAirRunningAverages(pm25historical:purpleAirData.sensor?.stats?.pm25_10minute ?? 0))"
                
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
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(Int(round(Double(climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0)))) US EPA AQI PM₂.₅, with primary pollutant of \(ClimaCellPrimaryPollutantText)"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0)), Grass: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0)), Weeds: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0))"
                    
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
                    title: "Electricity Consumption (electricityMap)...",
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
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(Int(round(Double(climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0)))) US EPA AQI PM₂.₅, with primary pollutant of \(ClimaCellPrimaryPollutantText)"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0)), Grass: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0)), Weeds: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0))"
                    
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
                    title: "Electricity Consumption (electricityMap)...",
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
            
            DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData1d(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData3d(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData1w(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData1M(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData1y(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            
            
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
                        aQI_CalculatedDouble = ((49)/(94.9))*((pM2_5Value)-55.5)+151
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
                        aQI_CalculatedDouble = ((99)/(99.9))*((pM2_5Value)-150.5)+201
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
                        aQI_CalculatedDouble = ((199)/(249.9))*((pM2_5Value)-250.5)+301
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
                    
                    var outputpm25historicalString1d: String = ""
                    var outputpm25historicalString3d: String = ""
                    var outputpm25historicalString1w: String = ""
                    var outputpm25historicalString1M: String = ""
                    var outputpm25historicalString1y: String = ""
                    
                    
                    if let pm25historicalString1d = smartCitizenHistoricalData1d.readings?[1][1]
                    {
                        outputpm25historicalString1d = String("\(pm25historicalString1d)")
                    }
                    
                    if let pm25historicalString3d = smartCitizenHistoricalData3d.readings?[1][1]
                    {
                        outputpm25historicalString3d = String("\(pm25historicalString3d)")
                    }
                    
                    if let pm25historicalString1w = smartCitizenHistoricalData1w.readings?[1][1]
                    {
                        outputpm25historicalString1w = String("\(pm25historicalString1w)")
                    }
                    
                    if let pm25historicalString1M = smartCitizenHistoricalData1M.readings?[0][1]
                    {
                        outputpm25historicalString1M = String("\(pm25historicalString1M)")
                    }
                    
                    if let pm25historicalString1y = smartCitizenHistoricalData1y.readings?[0][1]
                    {
                        outputpm25historicalString1y = String("\(pm25historicalString1y)")
                    }
                    
                    
                    self.smartCitizen24HourExposurePM25.title = "📊: Averages μg/m³ PM₂.₅:       1y: \(generatesmartCitizenAnnualAverage(pm25historicalString:outputpm25historicalString1y)) | 1m: \(generatesmartCitizenAnnualAverage(pm25historicalString:outputpm25historicalString1M)) | 1w: \(generatesmartCitizenAnnualAverage(pm25historicalString:outputpm25historicalString1w)) | 3d: \(generatesmartCitizen24HourAverage(pm25historicalString:outputpm25historicalString3d)) | 1d: \(generatesmartCitizen24HourAverage(pm25historicalString:outputpm25historicalString1d))"
                    
                    
                    func generatesmartCitizen24HourAverage(pm25historicalString:String) -> String{
                        
                        let step1 = pm25historicalString.replacingOccurrences(of: "[^\\.\\d+]", with: "", options: [.regularExpression])
                        
                        let step2 = NumberFormatter().number(from: step1)?.doubleValue
                        
                        let step3:Int = Int(round(step2 ?? 0.0))
                        
                        switch (step3) {
                            
                        case _ where step3 >= 0 && step3 < 15:
                            return String("\(step3) ✓")
                            
                        case _ where step3 >= 15 && step3 < 25:
                            return String("\(step3) ④")
                            
                        case _ where step3 >= 25 && step3 < 37:
                            return String("\(step3) ③")
                            
                        case _ where step3 >= 37 && step3 < 50:
                            return String("\(step3) ②")
                            
                        case _ where step3 >= 50 && step3 < 75:
                            return String("\(step3) ①")
                            
                        case _ where step3 >= 75:
                            return String("\(step3) ⓪")
                            
                        default:
                            return String("\(step3)")
                            
                        }
                        
                    }
                    
                    func generatesmartCitizenAnnualAverage(pm25historicalString:String) -> String{
                        
                        let step1 = pm25historicalString.replacingOccurrences(of: "[^\\.\\d+]", with: "", options: [.regularExpression])
                        
                        let step2 = NumberFormatter().number(from: step1)?.doubleValue
                        
                        let step3:Int = Int(round(step2 ?? 0.0))
                        
                        switch (step3) {
                            
                        case _ where step3 >= 0 && step3 < 5:
                            return String("\(step3) ✓")
                            
                        case _ where step3 >= 5 && step3 < 10:
                            return String("\(step3) ④")
                            
                        case _ where step3 >= 10 && step3 < 15:
                            return String("\(step3) ③")
                            
                        case _ where step3 >= 15 && step3 < 25:
                            return String("\(step3) ②")
                            
                        case _ where step3 >= 25 && step3 < 35:
                            return String("\(step3) ①")
                            
                        case _ where step3 >= 35:
                            return String("\(step3) ⓪")
                            
                        default:
                            return String("\(step3)")
                            
                        }
                        
                    }
                    
                    
                    self.smartCitizenOtherPollutants.title = "☁️: VOC \(String(Int(smartCitizenPresentData.data?.sensors?[0].value ?? 0)))\(String(smartCitizenPresentData.data?.sensors?[0].unit ?? "0")) / CO₂ \(String(Int(smartCitizenPresentData.data?.sensors?[1].value ?? 0)))\(String(smartCitizenPresentData.data?.sensors?[1].unit ?? "0"))"
                    
                    
                    self.smartCitizenTemperatureHumidity.title = "🌡: \(String(smartCitizenPresentData.data?.sensors?[10].value ?? 0))℃  /  💧: \(String(Int(smartCitizenPresentData.data?.sensors?[9].value ?? 0)))%"
                    
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
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(Int(round(Double(climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0)))) US EPA AQI PM₂.₅, with primary pollutant of \(ClimaCellPrimaryPollutantText)"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0)), Grass: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0)), Weeds: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0))"
                    
                    self.climaCellSolarGHI.title = "☀️: \(climaCellData.data?.timelines?[0].intervals?[1].values?.solarGHI ?? 0)W/m² potential solar generation (GHI)   \(solarGHI_visual)"
                    
                })
                
            }
        }
        
        
        
        
        
        if AppDelegate().defaults.integer(forKey:"SensorCommunityInUse") == 1 {
            
            let SensorCommunityLink = NSMenuItem(
                title: "Air Quality (SensorCommunity)...",
                action: #selector(menuFunctions.openSensorCommunity(_:)),
                keyEquivalent: "s"
            )
            SensorCommunityLink.target = self
            menu.addItem(SensorCommunityLink)
            
            menu.addItem(sensorCommunityLocationType)
            menu.addItem(sensorCommunityPM2_5)
            menu.addItem(sensorCommunityPM10)
            menu.addItem(sensorCommunityReadingAge)

            
            menu.addItem(NSMenuItem.separator())
            
            if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                
                menu.addItem(NSMenuItem.separator())
                let CO2Link = NSMenuItem(
                    title: "Electricity Consumption (electricityMap)...",
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
            
            DataLoaderSensorCommunity().loadSensorCommunityPresentData(id: (AppDelegate().defaults.object(forKey:"SensorCommunityStationID") as? String ?? String()))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                    DataLoaderCO2().loadCO2Data(lat: (sensorCommunityPresentData[0].location?.latitude ?? "0"), lon: (sensorCommunityPresentData[0].location?.longitude ?? "0"))
                }

                if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: ((Double(sensorCommunityPresentData[0].location?.latitude ?? "0") ?? 0)-1), lomin: ((Double(sensorCommunityPresentData[0].location?.longitude ?? "0") ?? 0)-1), lamax: ((Double(sensorCommunityPresentData[0].location?.latitude ?? "0") ?? 0)+1), lomax: ((Double(sensorCommunityPresentData[0].location?.longitude ?? "0") ?? 0)+1))
                }

                if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                    DataLoaderClimaCell().loadClimaCellData(lat: Double(sensorCommunityPresentData[0].location?.latitude ?? "0") ?? 0, lon: Double(sensorCommunityPresentData[0].location?.longitude ?? "0") ?? 0)
                }
                
                if 1 == 1 {

                    self.sensorCommunityLocationType.title = "🌍: \(String(sensorCommunityPresentData[0].location?.country ?? "0")) / Sensor ID: \(String(sensorCommunityPresentData[0].sensor?.id ?? 0))"



                    // AQI Calc from https://forum.airnowtech.org/t/the-aqi-equation/169

                    var pM2_5Value = round(Double(sensorCommunityPresentData[0].sensordatavalues?[1].value ?? "0") ?? 0)
                    let pM2_5ColourButton: String
                    let aQI_CalculatedDouble: Double
                    var aQI_CalculatedRounded: Int = 0
                    switch (pM2_5Value) {
                    case _ where pM2_5Value >= 0 && pM2_5Value < 12:
                        pM2_5ColourButton = "[🟢_____]"
                        self.sensorCommunityPM2_5StatusBarIcon.title = "🟢"
                        aQI_CalculatedDouble = ((50-0)/(12-0))*((pM2_5Value)-0)+0
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))

                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟢 Good AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Air quality is considered satisfactory, and air pollution poses little or no risk.")
                        }

                        AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")


                    case _ where pM2_5Value >= 12 && pM2_5Value < 35.5:
                        pM2_5ColourButton = "[_🟡_____]"
                        self.sensorCommunityPM2_5StatusBarIcon.title = "🟡"
                        statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((100-51)/(35.4-12.1))*((pM2_5Value)-12.1)+51
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))

                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        }


                        if AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
                        }

                        AppDelegate().defaults.set("🟡", forKey: "PreviousStateForNotification")


                    case _ where pM2_5Value >= 35.5 && pM2_5Value < 55.5:
                        pM2_5ColourButton = "[__🟠____]"
                        self.sensorCommunityPM2_5StatusBarIcon.title = "🟠"
                        statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((150-101)/(55.4-35.5))*((pM2_5Value)-35.5)+101
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))

                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
                        }

                        AppDelegate().defaults.set("🟠", forKey: "PreviousStateForNotification")


                    case _ where pM2_5Value >= 55.5 && pM2_5Value < 150.5:
                        pM2_5ColourButton = "[___🔴___]"
                        self.sensorCommunityPM2_5StatusBarIcon.title = "🔴"
                        statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((49)/(94.9))*((pM2_5Value)-55.5)+151
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))

                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
                        }

                        AppDelegate().defaults.set(self.sensorCommunityPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")


                    case _ where pM2_5Value >= 150.5 && pM2_5Value < 250.5:
                        pM2_5ColourButton = "[____🟣__]"
                        self.sensorCommunityPM2_5StatusBarIcon.title = "🟣"
                        statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((99)/(99.9))*((pM2_5Value)-150.5)+201
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))

                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟤") && AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1 && aQI_CalculatedRounded <= Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬇ 🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
                        }

                        AppDelegate().defaults.set(self.sensorCommunityPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")


                    case _ where pM2_5Value >= 250.5 && pM2_5Value < 500.5:
                        pM2_5ColourButton = "[_____🟤_]"
                        self.sensorCommunityPM2_5StatusBarIcon.title = "🟤"
                        statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        aQI_CalculatedDouble = ((199)/(245.5))*((pM2_5Value)-250.5)+301
                        aQI_CalculatedRounded = Int(round(aQI_CalculatedDouble))

                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                        }
                        AppDelegate().defaults.set(self.sensorCommunityPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")


                    case _ where pM2_5Value >= 500.5:
                        pM2_5ColourButton = "[______🟤]"
                        self.sensorCommunityPM2_5StatusBarIcon.title = "🟤"
                        statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        aQI_CalculatedRounded = 500

                        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1 {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title) \(aQI_CalculatedRounded)"
                        }
                        else
                        {
                            statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                        }

                        if (AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟢" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟡" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟠" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🔴" || AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as! String == "🟣") && AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1 && aQI_CalculatedRounded >= Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
                        {
                            AppDelegate().showNotification(title: "⬆ 🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(sensorCommunityPresentData[0].location?.country ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                        }
                        AppDelegate().defaults.set(self.sensorCommunityPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")


                    default:
                        pM2_5ColourButton = ""
                        self.sensorCommunityPM2_5StatusBarIcon.title = "⚪"
                        statusItem.button?.title = "M \(self.sensorCommunityPM2_5StatusBarIcon.title)"
                    }

                    self.sensorCommunityPM2_5.title = "☁️: \(String(aQI_CalculatedRounded)) US EPA AQI PM₂.₅ / \(sensorCommunityPresentData[0].sensordatavalues?[1].value ?? "0") μg/m³ PM₂.₅ (Current)                         \(pM2_5ColourButton)"


                    self.sensorCommunityPM10.title = "☁️: \(sensorCommunityPresentData[1].sensordatavalues?[1].value ?? "0") μg/m³ PM₁₀ (Current)"

                    self.sensorCommunityReadingAge.title = "📅: \(sensorCommunityPresentData[0].timestamp ?? "0")"

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
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(Int(round(Double(climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0)))) US EPA AQI PM₂.₅, with primary pollutant of \(ClimaCellPrimaryPollutantText)"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0)), Grass: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0)), Weeds: \(Int(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0))"
                    
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
            menu.addItem(trendAtmosphericCO2)
            menu.addItem(globalWarming)
            
            DataLoaderDailyAtmosphericCO2().loadDailyAtmosphericCO2Data()
            
            DataLoaderGlobalWarming().loadGlobalWarmingData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute:  {
                
                if (dailyAtmosphericCO2Data.co2?.last?.cycle) != nil {

                    let dailyAtmosphericCO2DataArraySize = dailyAtmosphericCO2Data.co2?.count ?? 0
                    
                    let dailyAtmosphericCO2DataArray365DaysAgo = dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-365]
                    let dailyAtmosphericCO2Data365DaysAgo = dailyAtmosphericCO2DataArray365DaysAgo?.trend ?? "0"
                    let cO2PPMLastAnnualDelta = ((dailyAtmosphericCO2Data.co2?.last?.trend ?? "0") as NSString).doubleValue - (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue
                    
//                    let dailyAtmosphericCO2DataArray730DaysAgo = dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-730]
//                    let dailyAtmosphericCO2Data730DaysAgo = dailyAtmosphericCO2DataArray730DaysAgo?.trend ?? "0"
//                    let cO2PPMPrecedingAnnualDelta = (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue - (dailyAtmosphericCO2Data730DaysAgo as NSString).doubleValue
//
//                    let cO2PPMLastYearOnYearDeltaPercentage = ((cO2PPMLastAnnualDelta - cO2PPMPrecedingAnnualDelta) / cO2PPMPrecedingAnnualDelta) * 100

                    let cO2PPMLastYearOnYearDeltaPercentage = (cO2PPMLastAnnualDelta / (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue) * 100
                    
                    
                    
                    
                    let daysSinceUNEPMilestone = ((((Date.timeIntervalSinceReferenceDate - 599529600)/60)/60)/24)
                    let yearsSinceUNEPMilestone = (((((Date.timeIntervalSinceReferenceDate - 599529600)/60)/60)/24)/365)

                    let dailyAtmosphericCO2DataArrayOnUNEPMilestone = ((dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-Int(daysSinceUNEPMilestone)].trend ?? "0") as NSString).doubleValue

//                    let cO2PPMAnnualAverageSinceUNEPMilestoneDeltaPercentage = ((((((dailyAtmosphericCO2Data.co2?[0].trend ?? "0") as NSString).doubleValue - dailyAtmosphericCO2DataArrayOnUNEPMilestone)) / (dailyAtmosphericCO2DataArrayOnUNEPMilestone)) / yearsSinceUNEPMilestone) * 100
                    
                    let cO2PPMAnnualAverageSinceUNEPMilestoneDeltaPercentage = (((((dailyAtmosphericCO2Data.co2?.last?.trend ?? "0") as NSString).doubleValue - dailyAtmosphericCO2DataArrayOnUNEPMilestone) / dailyAtmosphericCO2DataArrayOnUNEPMilestone) * 100) / yearsSinceUNEPMilestone
                    
                    self.dailyAtmosphericCO2.title = "⛽: \(String(dailyAtmosphericCO2Data.co2?.last?.trend ?? "0"))ppm CO₂ (Trend), \(String(format: "%.2f", locale: Locale.current, cO2PPMLastYearOnYearDeltaPercentage))% Δ Latest CO₂ Emissions on Last Year"
                    
                    self.trendAtmosphericCO2.title = "📈: Annualised Average Δ CO₂ Emissions since 2019: \(String(format: "%.1f", locale: Locale.current, cO2PPMAnnualAverageSinceUNEPMilestoneDeltaPercentage))%"
                    
                }
                
                let globalWarmingArraySize = globalWarmingData.result?.count ?? 0
                
                let globalWarmingDataArray1MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-1]
                let globalWarmingDataArray2MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-2]
                let globalWarmingDataArray3MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-3]
                let globalWarmingDataArray4MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-4]
                let globalWarmingDataArray5MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-5]
                let globalWarmingDataArray6MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-6]
                let globalWarmingDataArray7MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-7]
                let globalWarmingDataArray8MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-8]
                let globalWarmingDataArray9MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-9]
                let globalWarmingDataArray10MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-10]
                let globalWarmingDataArray11MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-11]
                let globalWarmingDataArray12MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-12]
                let globalWarmingDataArray13MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-13]
                let globalWarmingDataArray14MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-14]
                let globalWarmingDataArray15MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-15]
                let globalWarmingDataArray16MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-16]
                let globalWarmingDataArray17MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-17]
                let globalWarmingDataArray18MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-18]
                let globalWarmingDataArray19MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-19]
                let globalWarmingDataArray20MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-20]
                let globalWarmingDataArray21MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-21]
                let globalWarmingDataArray22MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-22]
                let globalWarmingDataArray23MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-23]
                let globalWarmingDataArray24MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-24]
                
                let globalWarmingLast12MonthsAgoTotal = (((globalWarmingDataArray1MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray2MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray3MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray4MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray5MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray6MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray7MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray8MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray9MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray10MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray11MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray12MonthsAgo?.land ?? "0") as NSString).doubleValue)
                let globalWarmingLast12MonthsAgoAverage = globalWarmingLast12MonthsAgoTotal / 12
                
                let globalWarming24MonthsAgo12MonthsTotal = (((globalWarmingDataArray13MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray14MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray15MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray16MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray17MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray18MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray19MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray20MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray21MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray22MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray23MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray24MonthsAgo?.land ?? "0") as NSString).doubleValue)
               let  globalWarming24MonthsAgo12MonthsAverage = globalWarming24MonthsAgo12MonthsTotal / 12
                
                let globalWarmingLastYearOnYearDeltaPercentage = ((globalWarmingLast12MonthsAgoAverage - globalWarming24MonthsAgo12MonthsAverage) / globalWarmingLast12MonthsAgoAverage) * 100
                
                self.globalWarming.title = "🌡: \(String(globalWarmingData.result?.last?.land ?? "0.00"))℃ \(String(globalWarmingData.result?.last?.time ?? "0")) Monthly mean surface temp. anomaly; \(String(format: "%.1f", locale: Locale.current, globalWarmingLastYearOnYearDeltaPercentage))% Δ Last Year on Preceding Year"
                
            })
            
        }
    }
}
