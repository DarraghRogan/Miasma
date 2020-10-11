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
    
    // the default location has top-notch food :-) (pork with fish sauce for the win)
    @State var sensorLatitude: Double = 53.3412
    @State var sensorLongitude: Double = -6.2507
    @State var locationCoordinate = CLLocationCoordinate2DMake(53.3412, -6.2507)
    @State var airQualityDataSource: String = ProfileEditor().AirQualityDataSource
    
    public var body: some View {
        
        VStack {
//            MapView(coordinate: locationCoordinate)
//                .edgesIgnoringSafeArea(.top)
//                .frame(height: 100)
            
            
            switch (airQualityDataSource) {
            case _ where airQualityDataSource == "WAQI/AQICN" :
                ContentViewWAQI()
            case _ where airQualityDataSource == "PurpleAir" :
                ContentViewPurpleAir()
            default:
                Link("Miasma ⇀",
                     destination: URL(string: "https://miasma.app")!)
                    .font(.headline)
            }
            
            Button("🔄", action: {
                if ProfileEditor().AirQualityDataSource == "WAQI/AQICN"{
                    airQualityDataSource = "WAQI/AQICN"
                    ContentViewWAQI().updateListEntry()
                }
                else if ProfileEditor().AirQualityDataSource == "PurpleAir"{
                    airQualityDataSource = "PurpleAir"
                    ContentViewPurpleAir().updateListEntry()
                }
            } )
            .offset(x: -159, y: -580)
            .padding(.top, -50)
            .font(.title)
            
            Button("🔧", action: { self.showingProfile.toggle() } )
                .offset(x: 159, y: -590)
                .padding(.top, -50)
                .font(.title)
            
            CircleImage()
                .offset(x: 0, y: -440)
                .padding(.top, -200)
            
        }
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
        }
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .gray]), startPoint: .leading, endPoint: .trailing))
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
        }
    }
}

//public func updateListEntry() {
//
//    DispatchQueue.main.async { // you need to update it in main thread!
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.sizeCategory, .small)
        }
    }
}
