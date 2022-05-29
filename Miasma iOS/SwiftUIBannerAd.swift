//
//  SwiftUIBannerAd.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 28/05/2022.
//  Copyright © 2022 Darragh Rogan. All rights reserved.
//

import Foundation
import SwiftUI
import GoogleMobileAds


struct SwiftUIBannerAd: View {
    @State var height: CGFloat = 0 //Height of ad
    @State var width: CGFloat = 0 //Width of ad
    @State var adPosition: AdPosition
    let adUnitId: String
    
    init(adPosition: AdPosition, adUnitId: String) {
        self.adPosition = adPosition
        self.adUnitId = adUnitId
    }
    
    enum AdPosition {
        case top
        case bottom
    }
    
    public var body: some View {
        VStack {
            if adPosition == .bottom {
                Spacer() //Pushes ad to bottom
            }
            
            //Ad
            BannerAd(adUnitId: adUnitId)
                .frame(width: width, height: height, alignment: .center)
                .onAppear {
                    //Call this in .onAppear() b/c need to load the initial frame size
                    //.onReceive() will not be called on initial load
                    setFrame()
                }
                //Changes the frame of the ad whenever the device is rotated.
                //This is what creates the adaptive ad
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    setFrame()
                }
            
            if adPosition == .top {
                Spacer() //Pushes ad to top
            }
        }
    }
    
    func setFrame() {
      
        //Get the frame of the safe area
        let safeAreaInsets = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero
        let frame = UIScreen.main.bounds.inset(by: safeAreaInsets)
        
        //Use the frame to determine the size of the ad
        let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.width)
        
        //Set the ads frame
        self.width = adSize.size.width
        self.height = adSize.size.height
    }
}
