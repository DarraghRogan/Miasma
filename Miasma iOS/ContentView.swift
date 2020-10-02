//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import CoreLocation



struct ContentView: View {
    
    @State var ListDestination: String = "0"
    
    @State var wAQILink: String = "0"
    @State var wAQIAttribution: String = "0"
    @State var wAQICity: String = "0"
    @State var wAQIAQI: Int = 0
    @State var wAQIDominentPol: String = "0"
    @State var wAQITemperature: Double = 0.0
    @State var wAQITime: String = "0"
    
    // the default location has top-notch food :-)
    @State var sensorLatitude: Double = 53.27829386648741
    @State var sensorLongitude: Double = -6.212225585789163
    @State var locationCoordinate = CLLocationCoordinate2DMake(53.27829386648741, -6.212225585789163)
    
    @State var cO2Country: String = "0"
    @State var carbonIntensity: Double = 0.0
    @State var fossilFuelPercentage: Double = 0.0
    
    
    var body: some View {
        VStack {
            MapView(coordinate: locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 125)
            
            CircleImage()
                .offset(x: 0, y: -115)
                .padding(.bottom, -115)
            
            List
            {
                VStack{
                    Link("Air Quality (WAQI) ⇀",
                         destination: URL(string: wAQILink)!)
                        .font(.title3)
                    
                    HStack {
                        Text("🌍")
                        Spacer()
                        Text("\(wAQICity)")
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("📜")
                        Spacer()
                        Text("\(wAQIAttribution)")
                            .lineLimit(1)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("☁️")
                        Spacer()
                        Text("US EPA PM₂.₅ AQI is \(wAQIAQI)")
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("🎯")
                        Spacer()
                        Text("Dominant Pollutant is \(wAQIDominentPol)")
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("🌡")
                        Spacer()
                        Text("\(String(wAQITemperature))℃")
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("📅")
                        Spacer()
                        Text("Taken: \(wAQITime)")
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    
                }
                VStack{
                    Link("Electricity Consumption (CO₂ Signal) ⇀",
                         destination: URL(string: "https://www.electricitymap.org/")!)
                        .font(.title3)
                    
                    HStack {
                        Text("🌍")
                        Spacer()
                        Text("\(cO2Country) Carbon Intensity is \(String(format: "%.1f", locale: Locale.current, carbonIntensity))gCO₂eq/kWh")
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("⚡️")
                        Spacer()
                        Text("\(String(format: "%.1f", locale: Locale.current,fossilFuelPercentage))% High Carbon in Energy mix")
                            .lineLimit(1)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                }
            }
        }
    }
    
    private func updateListEntry() {
        
        DataLoaderWAQI().loadWAQIData(id: "here")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                self.wAQILink = wAQIData.data?.city.url ?? "https://aqicn.org/here/"
                self.wAQIAttribution = wAQIData.data?.attributions[0].name ?? "0"
                self.wAQICity = wAQIData.data?.city.name ?? "0"
                self.wAQIAQI = wAQIData.data?.aqi ?? 0
                self.wAQIDominentPol = wAQIData.data?.dominentpol ?? "0"
                self.wAQITemperature = wAQIData.data?.iaqi.t?.v ?? 0
                self.wAQITime = wAQIData.data?.time.s ?? "0"
                
                self.locationCoordinate = CLLocationCoordinate2DMake(wAQIData.data?.city.geo[0] ?? 0, wAQIData.data?.city.geo[1] ?? 0)
                
                self.sensorLatitude = wAQIData.data?.city.geo[0] ?? 0
                self.sensorLongitude = wAQIData.data?.city.geo[1] ?? 0
                
                DataLoaderCO2().loadCO2Data(lat: String(sensorLatitude), lon: String(sensorLongitude))
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                self.cO2Country = cO2Data.countryCode ?? ""
                self.carbonIntensity = cO2Data.data?.carbonIntensity ?? 0
                self.fossilFuelPercentage = cO2Data.data?.fossilFuelPercentage ?? 0
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
