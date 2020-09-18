//
//  ViewController.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa
import ServiceManagement


class ViewController: NSViewController {
    
    // Invoke RegEx Extension for each account type
    let validityTypePurpleAir: String.ValidityType = .purpleAirID
    let validityTypeWAQI: String.ValidityType = .wAQICity
    
    @objc fileprivate func handleTextChangePurpleAir() {
        guard let text = PurpleAirIDField?.stringValue else { return }
        if text.isValid(validityTypePurpleAir) {
            DataLoaderPurpleAir().loadPurpleAirData(id: PurpleAirIDField.stringValue)
            PurpleAirCheckedLabel.stringValue = "Loading (5s)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
                
                if purpleAirData.results?.isEmpty ?? true {
                    self.PurpleAirCheckedLabel.stringValue = "Error. Check PurpleAir ID"
                } else {
                    self.PurpleAirCheckedLabel.stringValue = String(purpleAirData.results?[0].label ?? "")
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
    
    @IBOutlet weak var MiasmaVersionLabel: NSTextField!
    
    @IBOutlet weak var AirQualityDisabledRadioOutlet: NSButton!
    
    @IBAction func AirQualityDisabledRadioAction(_ sender: Any) {
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
        
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "WAQIInUse")
    }
    
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
    
    @IBOutlet weak var PurpleAirIDField: NSTextField!
    
    @IBAction func PurpleAirIDField(_ sender: Any) {
        PurpleAirCheckButton((Any).self)
    }
    
    @IBAction func PurpleAirRadioAction(_ sender: Any) {
        if PurpleAirSavedIDLabel.stringValue == ""{
            AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        }
        else{
            AppDelegate().defaults.set(1, forKey: "PurpleAirInUse")
            AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        }
        
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "WAQIInUse")
        
    }
    
    
    @IBOutlet weak var PurpleAirIDSaveButton: NSButton!
    
    @IBAction func PurpleAirIDSaveButton(_ sender: Any) {
        AppDelegate().defaults.set(PurpleAirIDField.stringValue, forKey: "PurpleAirStationID")
        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(1, forKey:"PurpleAirInUse")
        AppDelegate().defaults.set(0, forKey: "WAQIInUse")
        
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
    
    
    @IBOutlet weak var WAQIRadioOutlet: NSButton!
    
    @IBOutlet weak var WAQICheckedLabel: NSTextField!
    
    @IBOutlet weak var WAQISavedIDLabel: NSTextField!
    
    @IBOutlet weak var WAQISaveButtonOutlet: NSButton!
    
    @IBAction func WAQIRadioAction(_ sender: Any) {
        AppDelegate().defaults.set(1, forKey: "WAQIInUse")
        AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
        
    }
    
    @IBOutlet weak var WAQIComboBoxOutlet: NSComboBox!
    
    
    @IBAction func WAQIComboBoxAction(_ sender: Any) {
        handleTextChangeWAQI()
    }
    
    @IBAction func WAQISaveButtonAction(_ sender: Any) {
        AppDelegate().defaults.set(WAQIComboBoxOutlet.stringValue, forKey: "WAQICity")
        WAQISavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()
        AppDelegate().defaults.set(1, forKey: "WAQIInUse")
        AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        WAQIRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
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
    
    @IBOutlet weak var autoRunAtStartup: NSButton!
    
    @IBAction func autoRunAtStartup(_ sender: Any) {
        let launcherAppId = "Darragh-Rogan.MiasmaLauncherApplication"
        
        let isAuto = (sender as AnyObject).state == .on
        
        SMLoginItemSetEnabled(launcherAppId as CFString, isAuto)
        
        if autoRunAtStartup.state == NSControl.StateValue.off {
            AppDelegate().defaults.set(false, forKey: "AutorunAtStartup")
        }
        if autoRunAtStartup.state == NSControl.StateValue.on {
            AppDelegate().defaults.set(true, forKey: "AutorunAtStartup")
        }
    }
    
    let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        print(CO2SignalButtonOutlet.isOn)
        
        MiasmaVersionLabel.stringValue = (nsObject.self ?? 1.00 as AnyObject) as! String
        
        autoRunAtStartup.state.self = AppDelegate().defaults.object(forKey:"AutorunAtStartup") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        CO2SignalButtonOutlet.state = AppDelegate().defaults.object(forKey:"CO2SignalInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        OpenSkyButtonOutlet.state = AppDelegate().defaults.object(forKey:"OpenSkyInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        ClimaCellButtonOutlet.state = AppDelegate().defaults.object(forKey:"ClimaCellInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        
        if AppDelegate().defaults.integer(forKey:"PurpleAirInUse") == 1{
            PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        
        
        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
        
        WAQISavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"WAQICity") as? String ?? String()
        
        
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
    
    
}

