//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var ListDestination: String = "0"
    
    @State var wAQILink: String = "0"
    @State var wAQIAttribution: String = "0"
    @State var wAQICity: String = "0"
    @State var wAQIAQI: Int = 0
    @State var wAQIDominentPol: String = "0"
    @State var wAQITemperature: Double = 0.0
    @State var wAQITime: String = "0"
    
    var body: some View {
        
        
        List
            {
            VStack{
                Text("Air Quality (World Air Quality Index)...")
                    .fontWeight(.bold).font(.title3)
                //                Spacer()
                
                HStack {
                    Text("🌍: ")
                    Spacer()
                    Text("\(wAQICity)")
                        .font(.title3)
                        .onAppear() {
                            self.updateListEntry()
                        }
                }
                HStack {
                    Text("📜: ")
                    Spacer()
                    Text("\(wAQIAttribution)")
                        .onAppear() {
                            self.updateListEntry()
                        }
                }
                HStack {
                    Text("☁️: ")
                    Spacer()
                    Text("\(wAQIAQI) AQI (US EPA PM₂.₅, Current)")
                        .onAppear() {
                            self.updateListEntry()
                        }
                }
                HStack {
                    Text("🎯: Dominant Pollutant: ")
                    Spacer()
                    Text("\(wAQIDominentPol)")
                        .onAppear() {
                            self.updateListEntry()
                        }
                }
                
                HStack {
                    Text("🌡: ")
                    Spacer()
                    Text("\(wAQITemperature)")
                        .onAppear() {
                            self.updateListEntry()
                        }
                }
                
                HStack {
                    Text("📅: Reading Taken: ")
                    Spacer()
                    Text("\(wAQITime)")
                        .onAppear() {
                            self.updateListEntry()
                        }
                }
                
            }
            
            
            
        }
        
    }
    
    private func updateListEntry() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                self.wAQIAttribution = wAQIData.data?.attributions[0].name ?? "0"
                self.wAQICity = wAQIData.data?.city.name ?? "0"
                self.wAQIAQI = wAQIData.data?.aqi ?? 0
                self.wAQIDominentPol = wAQIData.data?.dominentpol ?? "0"
                self.wAQITemperature = wAQIData.data?.iaqi.t?.v ?? 0
                self.wAQITime = wAQIData.data?.time.s ?? "0"
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
