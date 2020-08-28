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
        AppDelegate().defaults.set(Covid19PopUpOutlet.titleOfSelectedItem, forKey: "APICovid19Country")
        AppDelegate().defaults.set(1, forKey: "APICovid19InUse")
        Covid19DisabledRadioOutlet.state.self = NSControl.StateValue(rawValue: 0)
        Covid19APIRadioOutlet.state.self = NSControl.StateValue(rawValue: 1)
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
        
        Covid19PopUpOutlet.removeAllItems()
        Covid19PopUpOutlet.addItems(withTitles: ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua-and-Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia-and-Herzegovina", "Brazil", "Brunei", "Bulgaria", "Burkina-Faso", "Cabo-Verde", "Cambodia", "Cameroon", "Canada", "CAR", "Cayman-Islands", "Chad", "Channel-Islands", "Chile", "China", "Colombia", "Congo", "Costa-Rica", "Croatia", "Cuba", "Cura&ccedil;ao", "Cyprus", "Czechia", "Denmark", "Diamond-Princess-", "Djibouti", "Dominican-Republic", "DRC", "Ecuador", "Egypt", "El-Salvador", "Equatorial-Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Faeroe-Islands", "Fiji", "Finland", "France", "French-Guiana", "French-Polynesia", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guyana", "Haiti", "Honduras", "Hong-Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle-of-Man", "Israel", "Italy", "Ivory-Coast", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kuwait", "Kyrgyzstan", "Latvia", "Lebanon", "Liberia", "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Madagascar", "Malaysia", "Maldives", "Malta", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Namibia", "Nepal", "Netherlands", "New-Caledonia", "New-Zealand", "Nicaragua", "Niger", "Nigeria", "North-Macedonia", "Norway", "Oman", "Pakistan", "Palestine", "Panama", "Papua-New-Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto-Rico", "Qatar", "R&eacute;union", "Romania", "Russia", "Rwanda", "S.-Korea", "Saint-Lucia", "Saint-Martin", "San-Marino", "Saudi-Arabia", "Senegal", "Serbia", "Seychelles", "Singapore", "Sint-Maarten", "Slovakia", "Slovenia", "Somalia", "South-Africa", "Spain", "Sri-Lanka", "St.-Barth", "St.-Vincent-Grenadines", "Sudan", "Suriname", "Sweden", "Switzerland", "Taiwan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Trinidad-and-Tobago", "Tunisia", "Turkey", "U.S.-Virgin-Islands", "UAE", "Uganda", "UK", "Ukraine", "Uruguay", "USA", "Uzbekistan", "Vatican-City", "Venezuela", "Vietnam", "Zambia", "Zimbabwe"])

        Covid19PopUpOutlet.selectItem(withTitle: AppDelegate().defaults.object(forKey:"APICovid19Country") as? String ?? String())
        
        
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

