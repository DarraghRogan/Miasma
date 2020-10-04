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
    
    @State var showingProfile = false
    @EnvironmentObject var userData: UserData
    
    @State var ListDestination: String = "◌"
    
    @State var wAQILink: String = "0"
    @State var wAQIAttribution: String = "◌"
    @State var wAQICity: String = "◌"
    @State var wAQIAQI: Int = 0
    @State var wAQIDominentPol: String = "◌"
    @State var wAQITemperature: Double = 0.0
    @State var wAQITime: String = "◌"
    
    // the default location has top-notch food :-) (pork with fish sauce for the win)
    @State var sensorLatitude: Double = 53.27829386648741
    @State var sensorLongitude: Double = -6.212225585789163
    @State var locationCoordinate = CLLocationCoordinate2DMake(53.27829386648741, -6.212225585789163)
    
    @State var cO2Country: String = "◌"
    @State var carbonIntensity: Double = 0.0
    @State var fossilFuelPercentage: Double = 0.0
    
    @State var openSkyAircraftInBox: Int = 0
    
    @State var climaCellWeatherCode: String = "◌"
    @State var climaCellWindDirection: Double = 0.0
    @State var climaCellFeelsLike: Double = 0.0
    @State var climaCellWindSpeed: Double = 0.0
    @State var climaCellEPAAQI: Int = 0
    @State var climaCellEPAPrimaryPollutant: String = "◌"
    @State var climaCellPollenTree: Int = 0
    @State var climaCellPollenGrass: Int = 0
    @State var climaCellPollenWeed: Int = 0
    
    
    var body: some View {
        
        VStack {
            
            MapView(coordinate: locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
            
            CircleImage()
                .offset(x: 0, y: -107)
                .padding(.bottom, -90)
            
            Button("Darragh", action: { self.showingProfile.toggle()
                    print("hello") } )
                                .offset(x: 159, y: -100)
                                .padding(.bottom, -24)
            
//            Button(action: { self.showingProfile.toggle()
//            }) {
//                Image(systemName: "square.and.arrow.down.on.square.fill")
//                    .imageScale(.large)
//                    .accessibility(label: Text("User Profile"))
//                    .offset(x: 159, y: -100)
//                    .padding(.bottom, -24)
//            }

            List
            {
                VStack{
                    Link("Air Quality (WAQI) ⇀",
                         destination: URL(string: wAQILink)!)
                        .font(.headline)
                    
                    HStack {
                        Text("🌍")
                        Spacer()
                        Text("\(wAQICity)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("📜")
                        Spacer()
                        Text("\(wAQIAttribution)")
                            .font(.footnote)
                            .lineLimit(1)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("☁️")
                        Spacer()
                        Text("US EPA PM₂.₅ AQI is \(wAQIAQI)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("🎯")
                        Spacer()
                        Text("Dominant Pollutant is \(wAQIDominentPol)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("🌡")
                        Spacer()
                        Text("\(String(wAQITemperature))℃")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("📅")
                        Spacer()
                        Text("Taken: \(wAQITime)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    
                }
                
                VStack{
                    Link("Electricity Consumption (CO₂ Signal) ⇀",
                         destination: URL(string: "https://www.electricitymap.org/")!)
                        .padding(.top, 8.0)
                        .font(.headline)
                    
                    HStack {
                        Text("🌍")
                        Spacer()
                        Text("\(cO2Country) Carbon Intensity is \(String(format: "%.1f", locale: Locale.current, carbonIntensity))gCO₂eq/kWh")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("⚡️")
                        Spacer()
                        Text("\(String(format: "%.1f", locale: Locale.current,fossilFuelPercentage))% High Carbon in Energy mix")
                            .font(.footnote)
                            .lineLimit(1)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                }
                
                VStack{
                    Link("Aircraft Overhead (OpenSky) ⇀",
                         destination: URL(string: "https://opensky-network.org/")!)
                        .padding(.top, 8.0)
                        .font(.headline)
                    
                    HStack {
                        Text("✈️")
                        Spacer()
                        Text("\(openSkyAircraftInBox) aircraft ±1° over Air Quality sensor")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    
                }
                
                VStack{
                    Link("1 Hour Forecast (ClimaCell Nearcast)⇀",
                         destination: URL(string: "https://www.climacell.co/consumer-app/")!)
                        .padding(.top, 8.0)
                        .font(.headline)
                    
                    HStack {
                        Text("🌦")
                        Spacer()
                        Text("Will be \(climaCellWeatherCode), feel like \(String(format: "%.1f", locale: Locale.current, climaCellFeelsLike))℃, with wind from \((String(format: "%.1f", locale: Locale.current, climaCellWindDirection)))° @ \(String(format: "%.1f", locale: Locale.current, climaCellWindSpeed))m/s")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("☁️")
                        Spacer()
                        Text("Air Quality will be \(climaCellEPAAQI) US EPA PM₂.₅ AQI, with primary pollutant of: \(climaCellEPAPrimaryPollutant)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Text("🌳")
                        Spacer()
                        Text("Pollen Index [0-5] will be: Trees: \(climaCellPollenTree), Grass: \(climaCellPollenGrass), Weeds: \(climaCellPollenWeed)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileHost()
                        .environmentObject(self.userData)
                }
            }
            
        }
        
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .gray]), startPoint: .leading, endPoint: .trailing))
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
                .environmentObject(self.userData)
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
                
                DataLoaderOpenSky().loadOpenSkyData(lamin: ((sensorLatitude )-1), lomin: ((sensorLongitude )-1), lamax: ((sensorLatitude)+1), lomax: ((sensorLongitude)+1))
                
                DataLoaderClimaCell().loadClimaCellData(lat: sensorLatitude, lon: sensorLongitude)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                self.cO2Country = cO2Data.countryCode ?? ""
                self.carbonIntensity = cO2Data.data?.carbonIntensity ?? 0
                self.fossilFuelPercentage = cO2Data.data?.fossilFuelPercentage ?? 0
                
                self.openSkyAircraftInBox = openSkyData.states?.count ?? 0
                
                self.climaCellWeatherCode = climaCellData[0].weatherCode?.value ?? ""
                self.climaCellWindDirection = climaCellData[0].windDirection?.value ?? 0
                self.climaCellFeelsLike = climaCellData[0].feelsLike?.value ?? 0
                self.climaCellWindSpeed = climaCellData[0].windSpeed?.value ?? 0
                self.climaCellEPAAQI = Int(round(climaCellData[0].epaAqi?.value ?? 0))
                self.climaCellEPAPrimaryPollutant = climaCellData[0].epaPrimaryPollutant?.value ?? ""
                self.climaCellPollenTree = Int(climaCellData[0].pollenTree?.value ?? 0)
                self.climaCellPollenGrass = Int(climaCellData[0].pollenGrass?.value ?? 0)
                self.climaCellPollenWeed = Int(climaCellData[0].pollenWeed?.value ?? 0)
                
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
