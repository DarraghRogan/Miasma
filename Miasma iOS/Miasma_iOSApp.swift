//
//  Miasma_iOSApp.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import UserMessagingPlatform

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // set up user defaults for people
        // this is where returning users should end up
        if defaults.bool(forKey: "First Launch") == true  {
            
        } else {
            // default config for new users
            
            defaults.set(true, forKey: "First Launch")
            defaults.set("here", forKey: "SensorID")
            defaults.set("WAQI/AQICN", forKey: "AirQualityDataSource")
            defaults.set(true, forKey:"ElectricalConsumptionDataWanted")
            //         defaults.set(true, forKey:"AircraftDataWanted")
            defaults.set(false, forKey:"OneHourForecastDataWanted")
            defaults.set(false, forKey:"TelraamDataWanted")
            defaults.set("9000002573", forKey: "segmentID")
            defaults.set(0.0, forKey: "UserLatitude")
            defaults.set(0.0, forKey: "UserLongitude")
            
        }
        
        return true
        
    }
    // Define the User Defaults to hold settings
    public let defaults = UserDefaults.standard
    
}
    
@main
struct Miasma_iOSApp: App {
    
    init() {
        requestIDFA()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func requestIDFA() {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            // Tracking authorization completed. Start loading ads here.
            showConsentInformation()
        })
    }
    
    private func showConsentInformation() {
        let parameters = UMPRequestParameters()
        
        // false means users are not under age.
        parameters.tagForUnderAgeOfConsent = false
        
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(
            with: parameters,
            completionHandler: { error in
                if error != nil {
                    // Handle the error.
                } else {
                    // The consent information state was updated.
                    // You are now ready to check if a form is
                    // available.
                    let formStatus = UMPConsentInformation.sharedInstance.formStatus
                    if formStatus == UMPFormStatus.available {
                      loadForm()
                    }
                }
            })
    }
    
    func loadForm() {
        UMPConsentForm.load(
            completionHandler: { form, loadError in
                if loadError != nil {
                    // Handle the error
                } else {
                    // Present the form
                    if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.required {
                        form?.present(from: UIApplication.shared.windows.first!.rootViewController! as UIViewController, completionHandler: { dimissError in
                            if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.obtained {
                                // App can start requesting ads.
                                initGoogleMobileAds()
                            }
                        })
                    }
                }
            })
    }
    
    private func initGoogleMobileAds() {
        GADMobileAds.sharedInstance()
            .start(completionHandler: nil)
    }
    
}


struct Miasma_iOSApp_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
