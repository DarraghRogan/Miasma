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
        return NSMenuItem(title: "🌫: ", action: nil, keyEquivalent: "")
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
    

    
    
    var aPICovid19Location : NSMenuItem = {
       return NSMenuItem(title: "🌍: ", action: nil, keyEquivalent: "")
    }()
    
    var aPICovid19Cases : NSMenuItem = {
       return NSMenuItem(title: "🗣: ", action: nil, keyEquivalent: "")
    }()
    
    var aPICovid19Deaths : NSMenuItem = {
       return NSMenuItem(title: "💀: ", action: nil, keyEquivalent: "")
    }()
    
    var aPICovid19Tests : NSMenuItem = {
       return NSMenuItem(title: "📝: ", action: nil, keyEquivalent: "")
    }()
    
    var aPICovid19Time : NSMenuItem = {
       return NSMenuItem(title: "📅: ", action: nil, keyEquivalent: "")
    }()
    
    

// Define how to open windows & web addresses from menu
   @objc func openPurpleAir(_ sender: NSMenuItem){
        NSWorkspace.shared.open(URL(string: "https://www.purpleair.com/map?opt=1/mPM25/a10/cC0&select=\(AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String())")!)
    }
    
    @objc func openWAQI(_ sender: NSMenuItem){
         NSWorkspace.shared.open(URL(string: "https://aqicn.org/here/")!)
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
            title: "Refresh (automatically every 10 minutes)",
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
            menu.addItem(NSMenuItem.separator())
            
             DataLoaderPurpleAir().loadPurpleAirData(id: (AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()))
             DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
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
                            
                            let Fahrenheit: Double = Double(purpleAirData.results?[0].tempF ?? "0")!
                            func calculateCelsius(fahrenheit: Double) -> String {
                                var celsius: Double
                                celsius = (fahrenheit - 32) * 5 / 9
                                let celciusRoundedString = String(format: "%.1f", locale: Locale.current, celsius)
                                return celciusRoundedString
                            }
                            self.purpleAirTemperature.title = "🌡: \(calculateCelsius(fahrenheit: Fahrenheit))℃ / \(String(purpleAirData.results?[0].tempF ?? "0"))℉"
                            
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
         }
         else {
             
         }
         
        
        if AppDelegate().defaults.integer(forKey:"WAQIInUse") == 1 {
            
            let aPICovid19 = NSMenuItem(
                title: "WAQI...",
                action: #selector(menuFunctions.openWAQI(_:)),
                keyEquivalent: "c"
            )
            aPICovid19.target = self
            menu.addItem(aPICovid19)
                
//            menu.addItem(aPICovid19Location)
//            menu.addItem(aPICovid19Cases)
//            menu.addItem(aPICovid19Deaths)
//            menu.addItem(aPICovid19Tests)
//            menu.addItem(aPICovid19Time)
            

         DataLoaderWAQI().loadWAQIData(id: (AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()))
         
//             DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
//
//             self.aPICovid19Location.title = "🌍: \(String(aPICovid19Data.response?[0].country ?? "0"))"
//
//             if aPICovid19Data.response?[0].country != nil {
//                let aPICovid19DataResponseCasesNew: Int = Int(aPICovid19Data.response?[0].cases?.new ?? "0")!
//                let aPICovid19DataResponseCasesThe1MPop : Int = Int(aPICovid19Data.response?[0].cases?.the1MPop ?? "0")!
//                 self.aPICovid19Cases.title = "🗣: \(String(format: "%U", locale: Locale.current, aPICovid19DataResponseCasesNew)) daily new cases / \(String(format: "%U", locale: Locale.current, aPICovid19DataResponseCasesThe1MPop)) total per 1 million polulation"
//             }
//
//                if aPICovid19Data.response?[0].deaths?.the1MPop != nil {
//                    let aPICovid19DataResponseDeathsNew: Int = Int(aPICovid19Data.response?[0].deaths?.new ?? "0")!
//                    let aPICovid19DataResponseDeathsThe1MPop : Float = Float(aPICovid19Data.response?[0].deaths?.the1MPop ?? "0")!
//             self.aPICovid19Deaths.title = "💀: \(String(format: "%U", locale: Locale.current, aPICovid19DataResponseDeathsNew)) daily new deaths / \(String(format: "%.1F", locale: Locale.current, aPICovid19DataResponseDeathsThe1MPop)) total per 1 million polulation"
//             }
//
//                if aPICovid19Data.response?[0].tests?.the1MPop != nil {
//                    let aPICovid19DataResponseTestsThe1MPop: Int = Int(aPICovid19Data.response?[0].tests?.the1MPop ?? "0")!
//             self.aPICovid19Tests.title = "📝: \(String(format: "%U", locale: Locale.current, aPICovid19DataResponseTestsThe1MPop)) tests per 1 million population"
//             }
//
//             self.aPICovid19Time.title = "📅: Data from \(String(aPICovid19Data.response?[0].day ?? "0"))"
//
//             })
//
//        }
//        else
//        {
//
//        }
        
    }
        
}
}
