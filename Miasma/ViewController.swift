//
//  ViewController.swift
//  Miasma
//
//  Created by Darragh Rogan on 21/08/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var AirQualityDisabledRadioOutlet: NSButton!
    
    @IBAction func AirQualityDisabledRadioAction(_ sender: Any) {
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(0, forKey: "PurpleAirInUse")
    }
        
    @IBOutlet weak var PurpleAirRadioOutlet: NSButton!
    
    @IBOutlet weak var PurpleAirIDField: NSTextField!
    
    @IBAction func PurpleAirRadioAction(_ sender: Any) {
        AppDelegate().defaults.set(1, forKey: "PurpleAirInUse")
        AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func PurpleAirIDSaveButton(_ sender: Any) {
        AppDelegate().defaults.set(PurpleAirIDField.stringValue, forKey: "PurpleAirStationID")
        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()
        PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        AppDelegate().defaults.set(1, forKey:"PurpleAirInUse")
    }
    
    @IBAction func PurpleAirCheckButton(_ sender: Any) {
        DataLoaderPurpleAir().loadPurpleAirData(id: PurpleAirIDField.stringValue)
        PurpleAirCheckedLabel.stringValue = "Loading (5s)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.1, execute: {
            if purpleAirData.results!.isEmpty {
                self.PurpleAirCheckedLabel.stringValue = "Error. Check PurpleAir ID"
            } else {
                self.PurpleAirCheckedLabel.stringValue = String(purpleAirData.results?[0].label ?? "")
            }
            

        })
        
        
    }
    
    @IBOutlet weak var PurpleAirCheckedLabel: NSTextField!
    
    @IBOutlet weak var PurpleAirSavedIDLabel: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if AppDelegate().defaults.integer(forKey:"PurpleAirInUse") == 0 {
            PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
            AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
        }
        else{
            PurpleAirRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
            AirQualityDisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        }


        PurpleAirSavedIDLabel.stringValue = AppDelegate().defaults.object(forKey:"PurpleAirStationID") as? String ?? String()

        
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

