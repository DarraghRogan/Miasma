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
        ZStack(alignment: .top) {
            VStack {
                
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
                
                Button("🔧", action: { self.showingProfile.toggle() } )
                    .offset(x: 159, y: -525)
                    .padding(.top, -50)
                    .font(.title)
                
                CircleImage()
                    .offset(x: 0, y: -267)
                    .padding(.top, -317)
                
                
                Spacer()
                
                Banner()
                
            }
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
                   }) {
                ProfileHost()
            }
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
