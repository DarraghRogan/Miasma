//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import CoreLocation

public struct ContentView: View {
    
    @State var showingProfile = false
    
    @State var ProgressIndicatorShown = true
    
    @State var airQualityDataSource: String = ProfileEditor().AirQualityDataSource
    
    public var body: some View {
        
        VStack {
            
            switch (airQualityDataSource) {
            case _ where airQualityDataSource == "WAQI/AQICN" :
                ContentViewWAQI()
            case _ where airQualityDataSource == "PurpleAir" :
                ContentViewPurpleAir()
            case _ where airQualityDataSource == "SmartCitizen" :
                ContentViewSmartCitizen()
            default:
                Link("Miasma ⇀",
                     destination: URL(string: "https://miasma.app")!)
                    .font(.headline)
            }
            
            Spacer()
            
            Banner()
            
        }
//        .overlay((CircleImage()
//                    .offset(x: 0, y: 0)), alignment: .center)
        .overlay((Button("🔧", action: { self.showingProfile.toggle() } )
                    .padding(EdgeInsets())
                    .offset(x: 155, y: 35)
                    .font(.title)), alignment: .top)
        
//        .edgesIgnoringSafeArea(.top)
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .gray]), startPoint: .leading, endPoint: .trailing))
        .sheet(isPresented: $showingProfile,
               onDismiss: {
                if ProfileEditor().AirQualityDataSource == "WAQI/AQICN"{
                    airQualityDataSource = "WAQI/AQICN"
                    ContentViewWAQI().updateListEntry()
                }
                else if ProfileEditor().AirQualityDataSource == "PurpleAir"{
                    airQualityDataSource = "PurpleAir"
                    ContentViewPurpleAir().updateListEntry()
                }
                else if ProfileEditor().AirQualityDataSource == "SmartCitizen"{
                    airQualityDataSource = "SmartCitizen"
                    ContentViewPurpleAir().updateListEntry()
                }
               }) {
            ProfileHost()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.sizeCategory, .small)
        }
    }
}

