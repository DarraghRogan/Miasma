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

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter({
                $0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}

func requestPermission() {
    if #available(iOS 14, *) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                // Tracking authorization dialog was shown
                // and we are authorized
                print("App Tracking Transparency Authorized")
                
                // Now that we are authorized we can get the IDFA
//                print(ASIdentifierManager.shared().advertisingIdentifier)
            case .denied:
                // Tracking authorization dialog was
                // shown and permission is denied
                print("App Tracking Transparency Denied")
            case .notDetermined:
                // Tracking authorization dialog has not been shown
                print("App Tracking Transparency Not Determined")
            case .restricted:
                print("App Tracking Transparency Restricted")
            @unknown default:
                print("App Tracking Transparency Unknown")
            }
        }
    }
}

@main
struct Miasma_iOSApp: App {
    
    init() {
//        requestIDFA()
        showConsentInformation()
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
                        form?.present(from: (UIApplication.shared.currentUIWindow()?.rootViewController)! as UIViewController, completionHandler: { dimissError in
                            if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.obtained {
                                // App can start requesting ads.
                                requestPermission()
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
