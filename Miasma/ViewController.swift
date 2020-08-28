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
    
    @IBOutlet weak var MiasmaVersionLabel: NSTextField!
    
    @IBOutlet weak var AirQualityDisabledRadioOutlet: NSButton!
    
    @IBAction func AirQualityDisabledRadioAction(_ sender: Any) {
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
    }
        
    @IBOutlet weak var PurpleAirRadioOutlet: NSButton!
    
    @IBAction func PurpleAirMapButton(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "http://www.purpleair.com/map")!)
    }
    
    @IBAction func PurpleAirWebpageSnip(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "http://www.purpleair.com/map")!)
    }
    
    @IBOutlet weak var PurpleAirIDField: NSTextField!
    
    @IBAction func PurpleAirIDField(_ sender: Any) {
            PurpleAirCheckButton((Any).self)
    }
    
    @IBAction func PurpleAirRadioAction(_ sender: Any) {
        AppDelegate().defaults.set(1, forKey: "PurpleAirInUse")
        AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
    }
    
    @IBOutlet weak var PurpleAirIDSaveButton: NSButton!
    
    @IBAction func PurpleAirIDSaveButton(_ sender: Any) {
        AppDelegate().defaults.set(PurpleAirIDField.stringValue, forKey: "PurpleAirStationID")
        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(1, forKey:"PurpleAirInUse")
//        menuFunctions()
        
    }
    
    @IBAction func PurpleAirCheckButton(_ sender: Any) {
        DataLoaderPurpleAir().loadPurpleAirData(id: PurpleAirIDField.stringValue)
        PurpleAirCheckedLabel.stringValue = "Loading (5s)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
            if purpleAirData.results!.isEmpty {
                self.PurpleAirCheckedLabel.stringValue = "Error. Check PurpleAir ID"
            } else {
                self.PurpleAirCheckedLabel.stringValue = String(purpleAirData.results?[0].label ?? "")
                self.PurpleAirIDSaveButton.isEnabled = true
            }
        })
        
        
    }
    
    @IBOutlet weak var PurpleAirCheckedLabel: NSTextField!
    
    @IBOutlet weak var PurpleAirSavedIDLabel: NSTextField!
    
    
    
    @IBOutlet weak var Covid19DisabledRadioOutlet: NSButton!
    
    @IBAction func Covid19DisabledRadioAction(_ sender: Any) {
        Covid19APIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "APICovid19InUse")
    }
    
    @IBOutlet weak var Covid19APIRadioOutlet: NSButton!
    
    @IBAction func Covid19APIRadioAction(_ sender: Any) {
        AppDelegate().defaults.set(1, forKey: "APICovid19InUse")
        Covid19DisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
    }
    
    @IBOutlet weak var Covid19PopUpOutlet: NSPopUpButton!
        
    @IBAction func Covid19PopUpAction(_ sender: Any) {
        AppDelegate().defaults.set(Covid19PopUpOutlet.selectedItem, forKey: "APICovid19Country")
    }
    
    
    
    let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MiasmaVersionLabel.stringValue = (nsObject.self ?? 1.00 as AnyObject) as! String
        
        if AppDelegate().defaults.integer(forKey:"PurpleAirInUse") == 0 {
            PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
            AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        else{
            PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
            AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        }


        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
        
        
        if AppDelegate().defaults.integer(forKey:"APICovid19InUse") == 0 {
            Covid19APIRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
            Covid19DisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        else{
            Covid19APIRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
            Covid19DisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        }

        Covid19PopUpOutlet.selectItem(withTitle: AppDelegate().defaults.object(forKey:"APICovid19Country") as? String ?? String())
        
        print(AppDelegate().defaults.object(forKey:"APICovid19Country"))
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

