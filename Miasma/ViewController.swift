 //
 //  ViewController.swift
 //  Miasma
 //
 //  Created by Darragh Rogan on 21/08/2020.
 //  Copyright © 2020 Darragh Rogan. All rights reserved.
 //
 
 import Cocoa
 import ServiceManagement
 import MapKit
 
 class ViewController: NSViewController {
    
    // Invoke RegEx Extension for each account type
    let validityTypePurpleAir: String.ValidityType = .purpleAirID
    let validityTypeWAQI: String.ValidityType = .wAQICity
    let validityTypeSmartCitizen: String.ValidityType = .smartCitizenStationID
    let validityTypeTelraam: String.ValidityType = .telraamSegmentID
     let validityTypeSensorCommunity: String.ValidityType = .sensorCommunityStationID
    
    
    @objc fileprivate func handleTextChangePurpleAir() {
        guard let text = PurpleAirIDField?.stringValue else { return }
        if text.isValid(validityTypePurpleAir) {
            DataLoaderPurpleAir().loadPurpleAirData(id: PurpleAirIDField.stringValue)
            PurpleAirCheckedLabel.stringValue = "Loading (5s)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if purpleAirData.sensor == nil {
                    self.PurpleAirCheckedLabel.stringValue = "Error. Check PurpleAir ID"
                } else {
                    self.PurpleAirCheckedLabel.stringValue = String(purpleAirData.sensor?.name ?? "")
                    self.PurpleAirIDSaveButton.isEnabled = true
                }
            })
            PurpleAirIDField.layer?.borderWidth = 0.0
        } else {
            PurpleAirIDField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            PurpleAirIDField.layer?.borderWidth = 2.0
        }
    }
    
    @objc fileprivate func handleTextChangeWAQI() {
        guard let text = WAQIComboBoxOutlet?.stringValue else { return }
        if text.isValid(validityTypeWAQI) {
            DataLoaderWAQI().loadWAQIData(id: WAQIComboBoxOutlet.stringValue)
            WAQICheckedLabel.stringValue = "Loading (5s)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if wAQIData.status?.isEmpty ?? true {
                    self.WAQICheckedLabel.stringValue = "Error. Check WAQI City / Station"
                } else {
                    self.WAQICheckedLabel.stringValue = String(wAQIData.data?.city.name ?? "")
                    self.WAQISaveButtonOutlet.isEnabled = true
                }
            })
            WAQIComboBoxOutlet.layer?.borderWidth = 0.0
        } else {
            WAQIComboBoxOutlet.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            WAQIComboBoxOutlet.layer?.borderWidth = 2.0
        }
    }
    
    @objc fileprivate func handleTextChangeSmartCitizen() {
        guard let text = SmartCitizenIDField?.stringValue else { return }
        if text.isValid(validityTypeSmartCitizen) {
            DataLoaderSmartCitizen().loadSmartCitizenPresentData(id: SmartCitizenIDField.stringValue)
            SmartCitizenCheckedLabel.stringValue = "Loading (5s)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if smartCitizenPresentData.name == nil {
                    self.SmartCitizenCheckedLabel.stringValue = "Error. Check SmartCitizen ID"
                } else {
                    self.SmartCitizenCheckedLabel.stringValue = String(smartCitizenPresentData.data?.location?.city ?? "")
                    self.SmartCitizenIDSaveButton.isEnabled = true
                }
            })
            SmartCitizenIDField.layer?.borderWidth = 0.0
        } else {
            SmartCitizenIDField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            SmartCitizenIDField.layer?.borderWidth = 2.0
        }
    }
    
    @objc fileprivate func handleTextChangeTelraam() {
        guard let text = TelraamSegmentIDOutlet?.stringValue else { return }
        if text.isValid(validityTypeTelraam) {
            DataLoaderTelraam().loadTelraamData(segmentID: TelraamSegmentIDOutlet.stringValue)
            TelraamCheckedLabel.stringValue = "Loading (5s)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if telraamData.features?.count ?? 0 > 0 {
                    
                    self.TelraamCheckedLabel.stringValue = String(telraamData.features?[0].properties?.oidn ?? 0)
                    self.TelraamSaveButton.isEnabled = true
                    
                } else {
                    self.TelraamCheckedLabel.stringValue = "Error. Check Telraam ID"
                }
                
//                if telraamData.features?[0].properties?.oidn == nil {
//                    self.TelraamCheckedLabel.stringValue = "Error. Check Telraam ID"
//                } else {
//                    self.TelraamCheckedLabel.stringValue = String(telraamData.features?[0].properties?.oidn ?? 0)
//                    self.TelraamSaveButton.isEnabled = true
//                }
            })
            TelraamSegmentIDOutlet.layer?.borderWidth = 0.0
        } else {
            TelraamSegmentIDOutlet.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            TelraamSegmentIDOutlet.layer?.borderWidth = 2.0
        }
    }
     
     @objc fileprivate func handleTextChangeSensorCommunity() {
         guard let text = SensorCommunityIDField?.stringValue else { return }
         if text.isValid(validityTypeSensorCommunity) {
             DataLoaderSensorCommunity().loadSensorCommunityPresentData(id: SensorCommunityIDField.stringValue)
             SensorCommunityCheckedLabel.stringValue = "Loading (5s)"
             DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                 
                 if sensorCommunityPresentData.isEmpty ?? true {
                     self.SensorCommunityCheckedLabel.stringValue = "Error. Check SensorCommunity ID"
                 } else {
                     self.SensorCommunityCheckedLabel.stringValue = "\(String(sensorCommunityPresentData[0].sensor?.id ?? 0))"
                     self.SensorCommunityIDSaveButton.isEnabled = true
                 }
             })
             SensorCommunityIDField.layer?.borderWidth = 0.0
         } else {
             SensorCommunityIDField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
             SensorCommunityIDField.layer?.borderWidth = 2.0
         }
     }
    
    
    @IBOutlet weak var MiasmaVersionLabel: NSTextField!
    
    
    @IBOutlet weak var PurpleAirRadioOutlet: NSButton!
    
    @IBAction func PurpleAirMapButton(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "http://www.purpleair.com/map")!)
    }
    
    @IBAction func PurpleAirWebpageSnip(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "http://www.purpleair.com/map")!)
    }
    
    @IBAction func WAQIMapButton(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://aqicn.org/city/all/")!)
    }
    
    @IBAction func TelraamMapButton(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://www.telraam.net/en")!)
        
    }
    
    
    @IBOutlet weak var PurpleAirIDField: NSTextField!
    
    @IBAction func PurpleAirIDField(_ sender: Any) {
        PurpleAirCheckButton((Any).self)
    }
    
    @IBAction func PurpleAirRadioAction(_ sender: Any) {
        if PurpleAirSavedIDLabel.stringValue == ""{
        }
        else{
            AppDelegate().defaults.set(1, forKey: "PurpleAirInUse")
        }
        
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "WAQIInUse")
        AppDelegate().defaults.set(0, forKey: "SmartCitizenInUse")
        AppDelegate().defaults.set(0, forKey: "SensorCommunityInUse")
    }
    
    @IBOutlet weak var PurpleAirIDSaveButton: NSButton!
    
    @IBAction func PurpleAirIDSaveButton(_ sender: Any) {
        AppDelegate().defaults.set(PurpleAirIDField.stringValue, forKey: "PurpleAirStationID")
        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(1, forKey:"PurpleAirInUse")
        AppDelegate().defaults.set(0, forKey: "WAQIInUse")
        AppDelegate().defaults.set(0, forKey: "SmartCitizenInUse")
        AppDelegate().defaults.set(0, forKey: "SensorCommunityInUse")
        
        AppDelegate().defaults.set(1, forKey:"CO2SignalInUse")
        CO2SignalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        AppDelegate().defaults.set(1, forKey:"OpenSkyInUse")
        OpenSkyButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        //        AppDelegate().defaults.set(1, forKey:"ClimaCellInUse")
        //        ClimaCellButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        
        if PurpleAirIDField.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
        }
        else{
        }
    }
    
    @IBAction func PurpleAirCheckButton(_ sender: Any) {
        handleTextChangePurpleAir()
        
    }
    
    @IBOutlet weak var PurpleAirCheckedLabel: NSTextField!
    
    @IBOutlet weak var PurpleAirSavedIDLabel: NSTextField!
    
    @IBAction func PurpleAirConversionEPAButtonAction(_ sender: Any) {
        if PurpleAirConversionEPAButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(0, forKey: "PurpleAirConversionFactorEPAInUse")
        }
        if PurpleAirConversionEPAButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(1, forKey: "PurpleAirConversionFactorEPAInUse")
        }
    }
    
    @IBOutlet weak var PurpleAirConversionEPAButtonOutlet: NSButton!
    
    @IBAction func PurpleAirConversionEPAMoreInfoButton(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://www2.purpleair.com/community/faq#hc-should-i-use-the-conversion-factors-on-the-purpleair-map-1")!)

    }
    
    
    
    @IBOutlet weak var WAQIRadioOutlet: NSButton!
    
    @IBOutlet weak var WAQICheckedLabel: NSTextField!
    
    @IBOutlet weak var WAQISavedIDLabel: NSTextField!
    
    @IBOutlet weak var WAQISaveButtonOutlet: NSButton!
    
    @IBAction func WAQIRadioAction(_ sender: Any) {
        AppDelegate().defaults.set(1, forKey: "WAQIInUse")
        
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
        
        SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "SmartCitizenInUse")
        
        SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "SensorCommunityInUse")
        
    }
    
    @IBOutlet weak var WAQIComboBoxOutlet: NSComboBox!
    
    
    @IBAction func WAQIComboBoxAction(_ sender: Any) {
        handleTextChangeWAQI()
    }
    
    @IBAction func WAQISaveButtonAction(_ sender: Any) {
        AppDelegate().defaults.set(WAQIComboBoxOutlet.stringValue, forKey: "WAQICity")
        WAQISavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()
        AppDelegate().defaults.set(1, forKey: "WAQIInUse")
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
        SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "SmartCitizenInUse")
        SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "SensorCommunityInUse")
        AppDelegate().defaults.set(1, forKey:"CO2SignalInUse")
        CO2SignalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        AppDelegate().defaults.set(1, forKey:"OpenSkyInUse")
        OpenSkyButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        //        AppDelegate().defaults.set(1, forKey:"ClimaCellInUse")
        //        ClimaCellButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        
        if WAQIComboBoxOutlet.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "WAQIInUse")
        }
        else{
        }
    }
    
    
    
    @IBOutlet weak var SmartCitizenRadioOutlet: NSButton!
    
    @IBAction func SmartCitizenMapButton(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://smartcitizen.me/kits/")!)
    }
    
    @IBOutlet weak var SmartCitizenIDField: NSTextField!
    
    @IBAction func SmartCitizenIDField(_ sender: Any) {
        SmartCitizenCheckButton((Any).self)
    }
    
    @IBAction func SmartCitizenRadioAction(_ sender: Any) {
        if SmartCitizenSavedIDLabel.stringValue == ""{
        }
        else{
            AppDelegate().defaults.set(1, forKey: "SmartCitizenInUse")
        }
        
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
        AppDelegate().defaults.set(0, forKey: "WAQIInUse")
        AppDelegate().defaults.set(0, forKey: "SensorCommunityInUse")
    }
    
    @IBOutlet weak var SmartCitizenIDSaveButton: NSButton!
    
    @IBAction func SmartCitizenIDSaveButton(_ sender: Any) {
        AppDelegate().defaults.set(SmartCitizenIDField.stringValue, forKey: "SmartCitizenStationID")
        SmartCitizenSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()
        SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(1, forKey:"SmartCitizenInUse")
        AppDelegate().defaults.set(0, forKey:"PurpleAirInUse")
        AppDelegate().defaults.set(0, forKey: "WAQIInUse")
        AppDelegate().defaults.set(0, forKey: "SensorCommunityInUse")
        
        AppDelegate().defaults.set(1, forKey:"CO2SignalInUse")
        CO2SignalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        AppDelegate().defaults.set(1, forKey:"OpenSkyInUse")
        OpenSkyButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        //        AppDelegate().defaults.set(1, forKey:"ClimaCellInUse")
        //        ClimaCellButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        
        if SmartCitizenIDField.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "SmartCitizenInUse")
        }
        else{
        }
    }
    
    @IBAction func SmartCitizenCheckButton(_ sender: Any) {
        handleTextChangeSmartCitizen()
    }
    
    @IBOutlet weak var SmartCitizenCheckedLabel: NSTextField!
    
    @IBOutlet weak var SmartCitizenSavedIDLabel: NSTextField!
    
     
     
     
     @IBOutlet weak var SensorCommunityRadioOutlet: NSButton!
     
     @IBAction func SensorCommunityMapButton(_ sender: Any) {
         NSWorkspace.shared.open(URL(string: "https://maps.sensor.community/")!)

     }
     
     @IBOutlet weak var SensorCommunityIDField: NSTextField!
     
     @IBAction func SensorCommunityIDField(_ sender: Any) {
         SensorCommunityCheckButton((Any).self)
     }
     
     @IBAction func SensorCommunityRadioAction(_ sender: Any) {
         if SensorCommunitySavedIDLabel.stringValue == ""{
         }
         else{
             AppDelegate().defaults.set(1, forKey: "SensorCommunityInUse")
         }
         
         PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
         WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
         SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
         AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
         AppDelegate().defaults.set(0, forKey: "WAQIInUse")
         AppDelegate().defaults.set(0, forKey: "SmartCitizenInUse")
     }
     
     @IBOutlet weak var SensorCommunityIDSaveButton: NSButton!
     
     
     @IBAction func SensorCommunityIDSaveButton(_ sender: Any) {
         AppDelegate().defaults.set(SensorCommunityIDField.stringValue, forKey: "SensorCommunityStationID")
         SensorCommunitySavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"SensorCommunityStationID") as? String ?? String()
         SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
         PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
         WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
         AppDelegate().defaults.set(1, forKey:"SensorCommunityInUse")
         AppDelegate().defaults.set(0, forKey:"PurpleAirInUse")
         AppDelegate().defaults.set(0, forKey: "WAQIInUse")
         AppDelegate().defaults.set(0, forKey: "SmartCitizenInUse")
         
         AppDelegate().defaults.set(1, forKey:"CO2SignalInUse")
         CO2SignalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
         AppDelegate().defaults.set(1, forKey:"OpenSkyInUse")
         OpenSkyButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
         //        AppDelegate().defaults.set(1, forKey:"ClimaCellInUse")
         //        ClimaCellButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
         
         if SensorCommunityIDField.stringValue == ""{
             AppDelegate().defaults.set(0, forKey: "SensorCommunityInUse")
         }
         else{
         }
     }
     
     @IBAction func SensorCommunityCheckButton(_ sender: Any) {
         handleTextChangeSensorCommunity()

     }
     
     @IBOutlet weak var SensorCommunityCheckedLabel: NSTextField!
     
     @IBOutlet weak var SensorCommunitySavedIDLabel: NSTextField!
     
     
    
    
    @IBAction func TelraamButton(_ sender: Any) {
        
        
        if TelraamSavedIDLabel.stringValue == ""{
            AppDelegate().defaults.set(false, forKey: "TelraamInUse")
        }
        else{
            if TelraamButtonOutlet.state == NSControl.StateValue.off {
                AppDelegate().defaults.set(false, forKey: "TelraamInUse")
            }
            if TelraamButtonOutlet.state == NSControl.StateValue.on {
                AppDelegate().defaults.set(true, forKey: "TelraamInUse")
            }
        }
    }
    
    @IBOutlet weak var TelraamButtonOutlet: NSButton!
    
    @IBAction func TelraamSegmentIDLabel(_ sender: Any) {
        //        AppDelegate().defaults.set(TelraamSegmentIDOutlet.stringValue, forKey: "TelraamSegmentID")
        handleTextChangeTelraam()
    }
    
    @IBOutlet weak var TelraamSegmentIDOutlet: NSTextField!
    
    @IBAction func TelraamCheckButton(_ sender: Any) {
        handleTextChangeTelraam()
    }
    
    @IBOutlet weak var TelraamCheckedLabel: NSTextField!
    
    @IBAction func TelraamSaveButton(_ sender: Any) {
        AppDelegate().defaults.set(TelraamSegmentIDOutlet.stringValue, forKey: "TelraamSegmentID")
        AppDelegate().defaults.set(true, forKey: "TelraamInUse")
        TelraamButtonOutlet.state.self = NSControl.StateValue.on
        TelraamSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"TelraamSegmentID") as? String ?? String()
    }
    
    @IBOutlet weak var TelraamSaveButton: NSButton!
    
    @IBOutlet weak var TelraamSavedIDLabel: NSTextField!
    
    
    
    
    
    @IBAction func CO2SignalButton(_ sender: Any) {
        
        if CO2SignalButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(false, forKey: "CO2SignalInUse")
            
        }
        if CO2SignalButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(true, forKey: "CO2SignalInUse")
            
        }
    }
    
    @IBOutlet weak var CO2SignalButtonOutlet: NSButton!
    
    @IBAction func OpenSkyButtonAction(_ sender: Any) {
        if OpenSkyButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(false, forKey: "OpenSkyInUse")
            
        }
        if OpenSkyButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(true, forKey: "OpenSkyInUse")
        }
    }
    
    @IBOutlet weak var OpenSkyButtonOutlet: NSButton!
    
    @IBAction func ClimaCellButtonAction(_ sender: Any) {
        if ClimaCellButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(false, forKey: "ClimaCellInUse")
            
        }
        if ClimaCellButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(true, forKey: "ClimaCellInUse")
        }
    }
    
    @IBOutlet weak var ClimaCellButtonOutlet: NSButton!
    
    @IBAction func RefreshIntervalButtonAction(_ sender: Any) {
        if RefreshIntervalButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(1800.0, forKey: "RefreshIntervalSeconds")
            ClimaCellButtonOutlet.isEnabled.self = true
        }
        if RefreshIntervalButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(900.0, forKey: "RefreshIntervalSeconds")
            AppDelegate().defaults.set(false, forKey: "ClimaCellInUse")
            ClimaCellButtonOutlet.isEnabled.self = false
            ClimaCellButtonOutlet.state.self = NSControl.StateValue.off

        }
    }
     
     @IBAction func DailyAtmosphericCO2Action(_ sender: Any) {
         if DailyAtmosphericCO2Outlet.state == NSControl.StateValue.off {
             AppDelegate().defaults.set(false, forKey: "ClimateChangeInUse")
             
         }
         if DailyAtmosphericCO2Outlet.state == NSControl.StateValue.on {
             AppDelegate().defaults.set(true, forKey: "ClimateChangeInUse")
         }
     }
     
     @IBOutlet weak var DailyAtmosphericCO2Outlet: NSButton!
     
    
    @IBOutlet weak var RefreshIntervalButtonOutlet: NSButton!
    
    
    @IBOutlet weak var autoRunAtStartup: NSButton!
    
    @IBAction func autoRunAtStartup(_ sender: Any) {
        let launcherAppId = "Darragh-Rogan.MiasmaLauncher"
        
        //        let isAuto = (sender as AnyObject).state == .on
        //
        //        SMLoginItemSetEnabled(launcherAppId as CFString, isAuto)
        
        if autoRunAtStartup.state.self == NSControl.StateValue.off{
            AppDelegate().defaults.set(false, forKey: "AutorunAtStartup")
            SMLoginItemSetEnabled(launcherAppId as CFString, false)
        }
        else if autoRunAtStartup.state.self == NSControl.StateValue.on{
            AppDelegate().defaults.set(true, forKey: "AutorunAtStartup")
            SMLoginItemSetEnabled(launcherAppId as CFString, true)
        }
        
        //        if autoRunAtStartup.state == NSControl.StateValue.off {
        //            AppDelegate().defaults.set(false, forKey: "AutorunAtStartup")
        //        }
        //        if autoRunAtStartup.state == NSControl.StateValue.on {
        //            AppDelegate().defaults.set(true, forKey: "AutorunAtStartup")
        //        }
    }
    
    
    
    @IBOutlet weak var receiveNotificationsButtonOutlet: NSButton!
    
    @IBOutlet weak var receiveFallingNotificationsButtonOutlet: NSButton!
    
    @IBAction func receiveNotificationsButtonAction(_ sender: Any) {
        if receiveNotificationsButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(0, forKey: "ClimbingAQINotificationsWanted")
        }
        if receiveNotificationsButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(1, forKey: "ClimbingAQINotificationsWanted")
        }
    }
    
    @IBAction func receiveFallingNotificationsButtonAction(_ sender: Any) {
        if receiveNotificationsButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(0, forKey: "FallingAQINotificationsWanted")
        }
        if receiveNotificationsButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(1, forKey: "FallingAQINotificationsWanted")
        }
    }
    
    
    @IBAction func ClimbingAQINotificationTriggerSliderAction(_ sender: Any) {
        
        AppDelegate().defaults.set(ClimbingAQINotificationTriggerSliderOutlet.intValue.self, forKey: "ClimbingAQINotificationsTrigger")
        AppDelegate().defaults.set(1, forKey: "ClimbingAQINotificationsWanted")
        receiveNotificationsButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        //        print(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
        CLimbingAQITriggerReadoutOutlet.stringValue.self = String(ClimbingAQINotificationTriggerSliderOutlet.intValue.self)
        
    }
    
    @IBAction func FallingAQINotificationTriggerSliderAction(_ sender: Any) {
        AppDelegate().defaults.set(FallingAQINotificationTriggerSliderOutlet.intValue.self, forKey: "FallingAQINotificationsTrigger")
        AppDelegate().defaults.set(1, forKey: "FallingQINotificationsWanted")
        receiveFallingNotificationsButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        FallingAQITriggerReadoutOutlet.stringValue.self = String(FallingAQINotificationTriggerSliderOutlet.intValue.self)
    }
    
    @IBOutlet weak var ClimbingAQINotificationTriggerSliderOutlet: NSSlider!
    
    @IBOutlet weak var FallingAQINotificationTriggerSliderOutlet: NSSlider!
    
    @IBOutlet weak var CLimbingAQITriggerReadoutOutlet: NSTextField!
    
    @IBOutlet weak var FallingAQITriggerReadoutOutlet: NSTextField!
    
    
    
    @IBAction func ShowAQIinMenubarButtonAction(_ sender: Any) {
        if ShowAQIinMenubarButtonOutlet.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(0, forKey: "ShowAQIinMenubar")
        }
        if ShowAQIinMenubarButtonOutlet.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(1, forKey: "ShowAQIinMenubar")
        }
    }
    
    @IBOutlet weak var ShowAQIinMenubarButtonOutlet: NSButton!
    
    
    //    @IBOutlet var mapView: MKMapView!
    //
    //    var mapAnnotations: [MKAnnotation] = []
    
    
    
    
    let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        //        self.mapAnnotations = []
        //
        //        let locationsAnnotation = LocationWAQI.loadLocationsWAQI()
        //        self.mapAnnotations.append(contentsOf: locationsAnnotation)
        //
        //
        //        self.mapView.addAnnotations(self.mapAnnotations)
        //        self.mapView.showsZoomControls = true
        
        
        MiasmaVersionLabel.stringValue = (nsObject.self ?? 1.00 as AnyObject) as! String
        
        autoRunAtStartup.state.self = AppDelegate().defaults.object(forKey:"AutorunAtStartup") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        if AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsWanted") == 1{
            receiveNotificationsButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
            ClimbingAQINotificationTriggerSliderOutlet.intValue.self = Int32(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
            CLimbingAQITriggerReadoutOutlet.stringValue.self = String(AppDelegate().defaults.integer(forKey:"ClimbingAQINotificationsTrigger"))
            
        }
        
        if AppDelegate().defaults.integer(forKey:"FallingAQINotificationsWanted") == 1{
            receiveFallingNotificationsButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
            FallingAQINotificationTriggerSliderOutlet.intValue.self = Int32(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
            FallingAQITriggerReadoutOutlet.stringValue.self = String(AppDelegate().defaults.integer(forKey:"FallingAQINotificationsTrigger"))
            
        }
        
        
        if AppDelegate().defaults.integer(forKey:"ShowAQIinMenubar") == 1{
            ShowAQIinMenubarButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        
        
        TelraamButtonOutlet.state = AppDelegate().defaults.object(forKey:"TelraamInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        CO2SignalButtonOutlet.state = AppDelegate().defaults.object(forKey:"CO2SignalInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        OpenSkyButtonOutlet.state = AppDelegate().defaults.object(forKey:"OpenSkyInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        ClimaCellButtonOutlet.state = AppDelegate().defaults.object(forKey:"ClimaCellInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        DailyAtmosphericCO2Outlet.state = AppDelegate().defaults.object(forKey:"ClimateChangeInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        PurpleAirConversionEPAButtonOutlet.state = AppDelegate().defaults.object(forKey:"PurpleAirConversionFactorEPAInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        if AppDelegate().defaults.double(forKey:"RefreshIntervalSeconds") == 600.0{
            RefreshIntervalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
            ClimaCellButtonOutlet.isEnabled.self = false
        }
        
        
        if AppDelegate().defaults.integer(forKey:"PurpleAirInUse") == 1{
            PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        
        if AppDelegate().defaults.integer(forKey:"SmartCitizenInUse") == 1{
            SmartCitizenRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        
        if AppDelegate().defaults.integer(forKey:"SensorCommunityInUse") == 1{
            SensorCommunityRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        
        
        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
        
        WAQISavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()
        
        SmartCitizenSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"SmartCitizenStationID") as? String ?? String()
        
        SensorCommunitySavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"SensorCommunityStationID") as? String ?? String()
        
        TelraamSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"TelraamSegmentID") as? String ?? String()
        
        if AppDelegate().defaults.integer(forKey:"WAQIInUse") == 1 {
            WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        
        WAQIComboBoxOutlet.removeAllItems()
        WAQIComboBoxOutlet.addItems(withObjectValues: [AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String(),"here","--------","Dublin","London","Krakow"])
        WAQIComboBoxOutlet.selectItem(at: 0)
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    //        @IBAction func locationChooseAction(_ targetButton: NSButton) {
    //
    //
    //            var title = mapView.selectedAnnotations[0].title
    //
    //            // directiosn from http://www.angelfire.com/space/one1/cal.html
    //            switch (title) {
    //            case _ where title == "PurpleAir":
    //                AppDelegate().defaults.set(mapView.selectedAnnotations[0].subtitle, forKey: "PurpleAirStationID")
    //                PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
    //                PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //                AppDelegate().defaults.set(1, forKey:"PurpleAirInUse")
    //                AppDelegate().defaults.set(0, forKey: "WAQIInUse")
    //                WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
    //
    //
    //                AppDelegate().defaults.set(1, forKey:"CO2SignalInUse")
    //                CO2SignalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //                AppDelegate().defaults.set(1, forKey:"OpenSkyInUse")
    //                OpenSkyButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //
    //            case _ where title == "WAQI":
    //                AppDelegate().defaults.set(mapView.selectedAnnotations[0].subtitle, forKey: "WAQICity")
    //                WAQISavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()
    //                AppDelegate().defaults.set(1, forKey: "WAQIInUse")
    //                WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //
    //                PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
    //                AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
    //                AppDelegate().defaults.set(1, forKey:"CO2SignalInUse")
    //                CO2SignalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //                AppDelegate().defaults.set(1, forKey:"OpenSkyInUse")
    //                OpenSkyButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //
    //            case _ where title == "SmartCitizen":
    //                AppDelegate().defaults.set(mapView.selectedAnnotations[0].subtitle, forKey: "SmartCityID")
    //
    //
    //            default:
    //                AppDelegate().defaults.set("here", forKey: "WAQICity")
    //                WAQISavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()
    //                AppDelegate().defaults.set(1, forKey: "WAQIInUse")
    //                WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //
    //                PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
    //                AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
    //                AppDelegate().defaults.set(1, forKey:"CO2SignalInUse")
    //                CO2SignalButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)
    //                AppDelegate().defaults.set(1, forKey:"OpenSkyInUse")
    //                OpenSkyButtonOutlet.state.self = NSControl.StateValue(rawValue: 1)            }
    //
    //    }
    
 }
 
 // extension ViewController: MKMapViewDelegate {
 //
 //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
 //        var returnedAnnotationView: MKAnnotationView? = nil
 //        guard !(annotation is MKUserLocation) else {
 //            return nil
 //        }
 //        returnedAnnotationView = LocationWAQI.createViewAnnotationForMapView(self.mapView, annotation: annotation)
 //
 //        // add a detail disclosure button to the callout which will open a popover for the bridge
 //        let rightButton = NSButton(frame: NSMakeRect(0.0, 0.0, 100.0, 80.0))
 //        rightButton.title = "Choose Station"
 //        rightButton.target = self
 //        rightButton.action = #selector(self.locationChooseAction(_:))
 //        rightButton.bezelStyle = .shadowlessSquare
 //        returnedAnnotationView!.rightCalloutAccessoryView = rightButton
 //        return returnedAnnotationView
 //    }
 // }
 
 
