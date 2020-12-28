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
    
    var smartCitizenTemperature : NSMenuItem = {
        return NSMenuItem(title: "🌡: ", action: nil, keyEquivalent: "")
    }()
    
    var smartCitizenHumidity : NSMenuItem = {
        return NSMenuItem(title: "💧: ", action: nil, keyEquivalent: "")
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
    
    
    var climaCellWeather : NSMenuItem = {
        return NSMenuItem(title: "🌦: ", action: nil, keyEquivalent: "")
    }()
    
    var climaCellAirQuality : NSMenuItem = {
        return NSMenuItem(title: "☁️: ", action: nil, keyEquivalent: "")
    }()
    
    var climaCellPollen : NSMenuItem = {
        return NSMenuItem(title: "🌳: ", action: nil, keyEquivalent: "")
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
    
    @objc func openClimaCell(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.climacell.co/consumer-app/")!)
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
                
                //                self.smartCitizenInfo1.title = "🌍: VOC \(String(smartCitizenData.data?.sensors?[0].value ?? 0)) \(String(smartCitizenData.data?.sensors?[0].unit ?? "0")) / CO2 \(String(smartCitizenData.data?.sensors?[1].value ?? 0)) \(String(smartCitizenData.data?.sensors?[1].unit ?? "0")) / Ambient Light \(String(smartCitizenData.data?.sensors?[2].value ?? 0)) \(String(smartCitizenData.data?.sensors?[2].unit ?? "0")) / Custom Circuit \(String(smartCitizenData.data?.sensors?[3].value ?? 0)) \(String(smartCitizenData.data?.sensors?[3].unit ?? "0")) "
                //
                //                self.smartCitizenInfo2.title = "🌍: Noise \(String(smartCitizenData.data?.sensors?[4].value ?? 0)) \(String(smartCitizenData.data?.sensors?[4].unit ?? "0")) / Pressure \(String(smartCitizenData.data?.sensors?[5].value ?? 0)) \(String(smartCitizenData.data?.sensors?[5].unit ?? "0")) / PM1 \(String(smartCitizenData.data?.sensors?[6].value ?? 0)) \(String(smartCitizenData.data?.sensors?[6].unit ?? "0")) / PM10 \(String(smartCitizenData.data?.sensors?[7].value ?? 0)) \(String(smartCitizenData.data?.sensors?[7].unit ?? "0"))"
                //
                //                self.smartCitizenInfo3.title = "🌍: PM2.5 \(String(smartCitizenData.data?.sensors?[8].value ?? 0)) \(String(smartCitizenData.data?.sensors?[8].unit ?? "0")) / Humidity \(String(smartCitizenData.data?.sensors?[9].value ?? 0))  \(String(smartCitizenData.data?.sensors?[9].unit ?? "0")) / Temperature \(String(smartCitizenData.data?.sensors?[10].value ?? 0))  \(String(smartCitizenData.data?.sensors?[10].unit ?? "0"))"
                
                
                
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
                
                var pM2_5Value = round(((purpleAirData.sensor?.pm25_A ?? 0) + (purpleAirData.sensor?.pm25_B ?? 0))/2)
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
                        AppDelegate().showNotification(title: "🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
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
                        AppDelegate().showNotification(title: "🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
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
                        AppDelegate().showNotification(title: "🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
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
                        AppDelegate().showNotification(title: "🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
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
                        AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
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
                        AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                    }
                    AppDelegate().defaults.set(self.purpleAirPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                    
                    
                default:
                    pM2_5ColourButton = ""
                    self.purpleAirPM2_5StatusBarIcon.title = "⚪"
                    statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
                }
                self.purpleAirPM2_5.title = "☁️: \(String(aQI_CalculatedRounded)) US EPA AQI PM₂.₅ / \(String(pM2_5Value)) μg/m³ PM₂.₅ (Current)                         \(pM2_5ColourButton)"
                
                // note including -8F & +4% corrections to temp & RH per: https://www.reddit.com/r/PurpleAir/comments/j14qln/temperature_reported_from_web_map_vs_api_mismatch/
                
                let PurpleAirFahrenheit = (purpleAirData.sensor?.temperatureA ?? 0)-8
                func calculateCelsius(fahrenheit: Double) -> String {
                    var celsius: Double
                    celsius = (fahrenheit - 32) * 5 / 9
                    let celciusRoundedString = String(format: "%.1f", locale: Locale.current, celsius)
                    return celciusRoundedString
                }
                self.purpleAirTemperature.title = "🌡: \(calculateCelsius(fahrenheit: Double(PurpleAirFahrenheit)))℃ / \(PurpleAirFahrenheit)℉"
                
                self.purpleAirHumidity.title = "💧: \(String((purpleAirData.sensor?.humidityA ?? 0)+4))% Relative Humidity"
                
                var pressureValue = Double(purpleAirData.sensor?.pressureA ?? 0) ?? 0
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
                self.purpleAirPressure.title = "🌬️: \(String(purpleAirData.sensor?.pressureA ?? 0)) millibar                                                      \(pressure_visual)"
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
                    
                    let ClimaCellCelcius = climaCellData[0].feelsLike?.value ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(climaCellData[0].weatherCode?.value ?? ""), \(String(format: "%.1f", locale: Locale.current, climaCellData[0].feelsLike?.value ?? 0))℃ / \(calculateFahrenheit(celcius: Double(ClimaCellCelcius)))℉, with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)))m/s / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)*3.6))km/h / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)*2.23694))mph"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(climaCellData[0].epaAqi?.value ?? 0)) US EPA AQI PM₂.₅, with primary pollutant of: \(climaCellData[0].epaPrimaryPollutant?.value ?? "")"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(String(format: "%.1f", locale: Locale.current, climaCellData[0].pollenTree?.value ?? 0)), Grass: \(String(format: "%.1f", locale: Locale.current, climaCellData[0].pollenGrass?.value ?? 0)), Weeds: \(String(format: "%.1f", locale: Locale.current, climaCellData[0].pollenWeed?.value ?? 0))"
                    
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
                            
                            AppDelegate().showNotification(title: "🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
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
                            
                            AppDelegate().showNotification(title: "🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
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
                            
                            AppDelegate().showNotification(title: "🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
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
                            
                            AppDelegate().showNotification(title: "🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
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
                            
                            AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(wAQIAQI) in \(String(wAQIData.data?.city.name ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
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
                    
                    let ClimaCellCelcius = climaCellData[0].feelsLike?.value ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(climaCellData[0].weatherCode?.value ?? ""), \(String(format: "%.1f", locale: Locale.current, climaCellData[0].feelsLike?.value ?? 0))℃ / \(calculateFahrenheit(celcius: Double(ClimaCellCelcius)))℉, with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)))m/s / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)*3.6))km/h / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)*2.23694))mph"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(climaCellData[0].epaAqi?.value ?? 0)) US EPA AQI PM₂.₅, with primary pollutant of: \(climaCellData[0].epaPrimaryPollutant?.value ?? "")"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(climaCellData[0].pollenTree?.value ?? 0), Grass: \(climaCellData[0].pollenGrass?.value ?? 0), Weeds: \(climaCellData[0].pollenWeed?.value ?? 0)"
                    
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
            menu.addItem(smartCitizenOtherPollutants)
            menu.addItem(smartCitizenTemperature)
            menu.addItem(smartCitizenHumidity)
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
            
            DataLoaderSmartCitizen().loadSmartCitizenData(id: (AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()))
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                
                if AppDelegate().defaults.integer(forKey:"CO2SignalInUse") == 1 {
                    DataLoaderCO2().loadCO2Data(lat: String(smartCitizenData.data?.location?.latitude ?? 0), lon: String(smartCitizenData.data?.location?.longitude ?? 0))
                }
                
                if AppDelegate().defaults.integer(forKey:"OpenSkyInUse") == 1 {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: ((smartCitizenData.data?.location?.latitude ?? 0)-1), lomin: ((smartCitizenData.data?.location?.longitude ?? 0)-1), lamax: ((smartCitizenData.data?.location?.latitude ?? 0)+1), lomax: ((smartCitizenData.data?.location?.longitude ?? 0)+1))
                }
                
                if AppDelegate().defaults.integer(forKey:"ClimaCellInUse") == 1 {
                    DataLoaderClimaCell().loadClimaCellData(lat: smartCitizenData.data?.location?.latitude ?? 0, lon: smartCitizenData.data?.location?.longitude ?? 0)
                }
                
                if 1 == 1 {
                    
                    self.smartCitizenLocationType.title = "🌍: \(String(smartCitizenData.data?.location?.city ?? "0")), \(String(smartCitizenData.data?.location?.country ?? "0")) / Exposure: \(String(smartCitizenData.data?.location?.exposure ?? "0"))"
                    
                    
                    
                    // AQI Calc from https://forum.airnowtech.org/t/the-aqi-equation/169
                    
                    var pM2_5Value = round(smartCitizenData.data?.sensors?[8].value ?? 0)
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
                        AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")
                        
                        
                    case _ where pM2_5Value >= 12 && pM2_5Value < 35.5:
                        pM2_5ColourButton = "[_🟡_____]"
                        self.smartCitizenPM2_5StatusBarIcon.title = "🟡"
                        statusItem.button?.title = "M \(self.purpleAirPM2_5StatusBarIcon.title)"
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
                            AppDelegate().showNotification(title: "🟡 Moderate AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(purpleAirData.sensor?.name ?? "0"))", informativeText: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people.")
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
                            AppDelegate().showNotification(title: "🟠 Unhealthy for Sensitive Groups AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenData.data?.location?.city ?? "0"))", informativeText: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.")
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
                            AppDelegate().showNotification(title: "🔴 Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenData.data?.location?.city ?? "0"))", informativeText: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.")
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
                            AppDelegate().showNotification(title: "🟣 Very Unhealthy AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenData.data?.location?.city ?? "0"))", informativeText: "Health alert: everyone may experience more serious health effects.")
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
                            AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenData.data?.location?.city ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
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
                            AppDelegate().showNotification(title: "🟤 Hazardous AQI reached", subtitle: "Air Quality Index is \(aQI_CalculatedRounded) in \(String(smartCitizenData.data?.location?.city ?? "0"))", informativeText: "Health warnings of emergency conditions. The entire population is more likely to be affected.")
                        }
                        AppDelegate().defaults.set(self.smartCitizenPM2_5StatusBarIcon.title, forKey: "PreviousStateForNotification")
                        
                        
                    default:
                        pM2_5ColourButton = ""
                        self.smartCitizenPM2_5StatusBarIcon.title = "⚪"
                        statusItem.button?.title = "M \(self.smartCitizenPM2_5StatusBarIcon.title)"
                    }
                    self.smartCitizenPM2_5.title = "☁️: \(String(aQI_CalculatedRounded)) US EPA AQI PM₂.₅ / \(String(pM2_5Value)) μg/m³ PM₂.₅ (Current)                         \(pM2_5ColourButton)"
                    
                    
                    self.smartCitizenOtherPollutants.title = "☁️: VOC \(String(smartCitizenData.data?.sensors?[0].value ?? 0))\(String(smartCitizenData.data?.sensors?[0].unit ?? "0")) / CO2 \(String(smartCitizenData.data?.sensors?[1].value ?? 0))\(String(smartCitizenData.data?.sensors?[1].unit ?? "0"))"
                    
                    self.smartCitizenTemperature.title = "🌡: \(String(smartCitizenData.data?.sensors?[10].value ?? 0))℃"
                    
                    self.smartCitizenHumidity.title = "💧: \(String(smartCitizenData.data?.sensors?[9].value ?? 0))%"
                    
                    var pressureValue = smartCitizenData.data?.sensors?[5].value ?? 0
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
                    self.smartCitizenPressure.title = "🌬️: \(String(smartCitizenData.data?.sensors?[5].value ?? 0))kilopascal                                                                   \(pressure_visual)"
                    
                    
                    self.smartCitizenPhysicalProperties.title = "🎤: Noise \(String(smartCitizenData.data?.sensors?[4].value ?? 0))\(String(smartCitizenData.data?.sensors?[4].unit ?? "0")) / Ambient Light \(String(smartCitizenData.data?.sensors?[2].value ?? 0))\(String(smartCitizenData.data?.sensors?[2].unit ?? "0"))"
                    
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
                    
                    let ClimaCellCelcius = climaCellData[0].feelsLike?.value ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    
                    self.climaCellWeather.title = "🌦: Will be \(climaCellData[0].weatherCode?.value ?? ""), \(String(format: "%.1f", locale: Locale.current, climaCellData[0].feelsLike?.value ?? 0))℃ / \(calculateFahrenheit(celcius: Double(ClimaCellCelcius)))℉, with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)))m/s / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)*3.6))km/h / \(String(format: "%.1f", locale: Locale.current, Double(climaCellData[0].windSpeed?.value ?? 0)*2.23694))mph"
                    
                    self.climaCellAirQuality.title = "☁️: Air Quality will be \(round(climaCellData[0].epaAqi?.value ?? 0)) US EPA AQI PM₂.₅, with primary pollutant of: \(climaCellData[0].epaPrimaryPollutant?.value ?? "")"
                    
                    self.climaCellPollen.title = "🌳: Pollen Index [0-5] will be: Trees: \(climaCellData[0].pollenTree?.value ?? 0), Grass: \(climaCellData[0].pollenGrass?.value ?? 0), Weeds: \(climaCellData[0].pollenWeed?.value ?? 0)"
                    
                })
                
            }
        }
        
    }
}
