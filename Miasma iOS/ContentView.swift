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
    
    // Heavly implementing combine per https://engineering.nodesagency.com/categories/ios/2020/03/16/Combine-networking-with-a-hint-of-swiftUI
    
    @ObservedObject var wAQIViewModel = WAQIViewModel()
    @ObservedObject var purpleAirViewModel = PurpleAirViewModel()
    
    @State var showingProfile = false
    
    @State var ProgressIndicatorShown = true
    
    // the default location has top-notch food :-) (pork with fish sauce for the win)
    @State var sensorLatitude: Double = 53.3412
    @State var sensorLongitude: Double = -6.2507
    @State var locationCoordinate = CLLocationCoordinate2DMake(53.3412, -6.2507)
    
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
    
    @State var pM2_5Value: Double = 0
    @State var pM2_5ColourButton: String = "[______]"
    @State var aQI_CalculatedDouble: Double = 0
    @State var aQI_CalculatedRounded: Int = 0
    
    
    public var body: some View {
        
        VStack {
            
            MapView(coordinate: locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
            
            Button("🔄", action: {
                purpleAirViewModel.getPurpleAir()
                purpleAirViewModel.objectWillChange.send()
                updateListEntry()
            } )
            .offset(x: -159, y: -108)
            .padding(.bottom, -32)
            .font(.title)
            .foregroundColor(.black)
            
            Button("🔧", action: { self.showingProfile.toggle() } )
                .offset(x: 159, y: -115)
                .padding(.bottom, -32)
                .font(.title)
                .foregroundColor(.black)
            
            CircleImage()
                .offset(x: 0, y: -122)
                .padding(.bottom, -80)
            
            List
            {
                
                switch (ProfileEditor().AirQualityDataSource) {
                case _ where ProfileEditor().AirQualityDataSource == "WAQI/AQICN" :
                    
                    VStack{
                        Link("Air Quality (WAQI) ⇀",
                             destination: URL(string: wAQIViewModel.wAQIdata.city?.url ?? "https://aciqn.org")!)
                            .font(.headline)
                        
                        HStack {
                            Text("🌍")
                            Spacer()
                            Text(wAQIViewModel.wAQIdata.city?.name ?? "0")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("📜")
                            Spacer()
                            Text(wAQIViewModel.wAQIdata.attributions?[0].name ?? "0")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("☁️")
                            Spacer()
                            Text("US EPA PM₂.₅ AQI is \(String(wAQIViewModel.wAQIdata.aqi ?? 0))")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("🎯")
                            Spacer()
                            Text("Dominant Pollutant is \(wAQIViewModel.wAQIdata.dominentpol ?? "0")")
                                .font(.footnote)
                                .padding(.top, 5.0)
                            
                        }
                        
                        HStack {
                            Text("🌡")
                            Spacer()
                            Text("\(String(wAQIViewModel.wAQIdata.iaqi?.t?.v ?? 0))℃")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("📅")
                            Spacer()
                            Text("Taken: \(String(wAQIViewModel.wAQIdata.time?.s ?? "0")) \(String(wAQIViewModel.wAQIdata.time?.tz ?? "0"))")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                    }
                    
                case _ where ProfileEditor().AirQualityDataSource == "PurpleAir" :
                    
                    
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("Air Quality (PurpleAir) ⇀",
                             destination: URL(string: "https://www.purpleair.com/map?opt=1/mAQI/a0/cC0&select=\(ProfileEditor().SensorID)")!)
                            .font(.headline)
                        
                        HStack {
                            Text("🌍")
                            Spacer()
                            Text("\(purpleAirViewModel.purpleAirdata.name ?? "0")")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("☁️")
                            Spacer()
                            Text("US EPA AQI PM₂.₅ is \(self.aQI_CalculatedRounded)     \(self.pM2_5ColourButton)")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("🌡")
                            Spacer()
                            Text("\(String((purpleAirViewModel.purpleAirdata.temperatureA ?? 0)-8))℉")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("💧")
                            Spacer()
                            Text("\(String((purpleAirViewModel.purpleAirdata.humidityA ?? 0)+4))% Relative Humidity")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("🌬️")
                            Spacer()
                            Text("\(String(purpleAirViewModel.purpleAirdata.pressureA ?? 0)) millibar")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                        
                        HStack {
                            Text("📅")
                            Spacer()
                            Text("Taken: \(String(Int((NSDate().timeIntervalSince1970))-(purpleAirViewModel.purpleAirdata.lastSeen ?? 0))) seconds old at Miasma refresh time")
                                .font(.footnote)
                                .padding(.top, 5.0)
                        }
                    }
                    
                    
                default:
                    Link("Miasma ⇀",
                         destination: URL(string: "https://miasma.app")!)
                        .font(.headline)
                }
                
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
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
                    
                }
                
                if ProfileEditor().AircraftDataWanted == true
                {
                    
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
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
                    
                }
                
                if ProfileEditor().OneHourForecastDataWanted == true
                {
                    
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
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
                    
                }
                
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
            
        }
        
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .gray]), startPoint: .leading, endPoint: .trailing))
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
        }
    }
    
    
    public func updateListEntry() {
        
        ProgressIndicatorShown = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.05) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                print("running +3s data loaders")
                
                ProgressIndicatorShown = true
                
                
                switch (ProfileEditor().AirQualityDataSource) {
                case _ where ProfileEditor().AirQualityDataSource == "WAQI/AQICN" :
                    
                    self.locationCoordinate = CLLocationCoordinate2DMake(wAQIViewModel.wAQIdata.city?.geo[0] ?? 0, wAQIViewModel.wAQIdata.city?.geo[1] ?? 0)
                    
                    self.sensorLatitude = wAQIViewModel.wAQIdata.city?.geo[0] ?? 0
                    self.sensorLongitude = wAQIViewModel.wAQIdata.city?.geo[1] ?? 0
                    
                case _ where ProfileEditor().AirQualityDataSource == "PurpleAir" :
                    
                    self.locationCoordinate = CLLocationCoordinate2DMake(purpleAirViewModel.purpleAirdata.latitude ?? 0, purpleAirViewModel.purpleAirdata.longitude ?? 0)
                    
                    self.sensorLatitude = purpleAirViewModel.purpleAirdata.latitude ?? 0
                    self.sensorLongitude = purpleAirViewModel.purpleAirdata.longitude ?? 0
                    
                    self.pM2_5Value = round(((purpleAirViewModel.purpleAirdata.pm25_A ?? 0) + (purpleAirViewModel.purpleAirdata.pm25_B ?? 0))/2)
                    switch (pM2_5Value) {
                    case _ where pM2_5Value > 0 && pM2_5Value < 12:
                        self.pM2_5ColourButton = "[🟢_____]"
                        self.aQI_CalculatedDouble = ((50-0)/(12-0))*((pM2_5Value)-0)+0
                        self.aQI_CalculatedRounded = Int(round(self.aQI_CalculatedDouble))
                        AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")

                    case _ where pM2_5Value > 12 && pM2_5Value < 35.5:
                        self.pM2_5ColourButton = "[_🟡_____]"
                        self.aQI_CalculatedDouble = ((100-51)/(35.4-12.1))*((pM2_5Value)-12.1)+51
                        self.aQI_CalculatedRounded = Int(round(self.aQI_CalculatedDouble))
                        AppDelegate().defaults.set("🟡", forKey: "PreviousStateForNotification")

                    case _ where pM2_5Value > 35.5 && pM2_5Value < 55.5:
                        self.pM2_5ColourButton = "[__🟠____]"
                        self.aQI_CalculatedDouble = ((150-101)/(55.4-35.5))*((pM2_5Value)-35.5)+101
                        self.aQI_CalculatedRounded = Int(round(self.aQI_CalculatedDouble))
                        AppDelegate().defaults.set("🟠", forKey: "PreviousStateForNotification")

                    case _ where pM2_5Value > 55.5 && pM2_5Value < 150.5:
                        self.pM2_5ColourButton = "[___🔴___]"
                        aQI_CalculatedDouble = ((200-151)/(150.4-55.5))*((pM2_5Value)-55.5)+151
                        self.aQI_CalculatedRounded = Int(round(self.aQI_CalculatedDouble))
                        AppDelegate().defaults.set("🔴", forKey: "PreviousStateForNotification")

                    case _ where pM2_5Value > 150.5 && pM2_5Value < 250.5:
                        self.pM2_5ColourButton = "[____🟣__]"
                        self.aQI_CalculatedDouble = ((300-201)/(250.4-150.5))*((pM2_5Value)-150.5)+201
                        self.aQI_CalculatedRounded = Int(round(self.aQI_CalculatedDouble))
                        AppDelegate().defaults.set("🟣", forKey: "PreviousStateForNotification")

                    case _ where pM2_5Value > 250.5 && pM2_5Value < 500.5:
                        self.pM2_5ColourButton = "[_____🟤_]"
                        self.aQI_CalculatedDouble = ((500-301)/(500.4-250.5))*((pM2_5Value)-250.5)+301
                        self.aQI_CalculatedRounded = Int(round(self.aQI_CalculatedDouble))
                        AppDelegate().defaults.set("🟤", forKey: "PreviousStateForNotification")

                    case _ where pM2_5Value > 500.5:
                        self.pM2_5ColourButton = "[______🟤]"
                        self.aQI_CalculatedRounded = 500
                        AppDelegate().defaults.set("🟤", forKey: "PreviousStateForNotification")

                    default:
                        self.pM2_5ColourButton = "[_______]"
                        self.aQI_CalculatedRounded = 0
                        AppDelegate().defaults.set("⚪", forKey: "PreviousStateForNotification")
                    }
                    
                default:
                    
                    self.locationCoordinate = CLLocationCoordinate2DMake(53.3412, -6.2507)
                    
                    self.sensorLatitude = 53.3412
                    self.sensorLongitude = -6.2507
                    
                }
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    DataLoaderCO2().loadCO2Data(lat: String(sensorLatitude), lon: String(sensorLongitude))
                }
                
                if ProfileEditor().AircraftDataWanted == true
                {
                    DataLoaderOpenSky().loadOpenSkyData(lamin: sensorLatitude-1, lomin: sensorLongitude-1, lamax: sensorLatitude+1, lomax: sensorLongitude+1)
                }
                
                if ProfileEditor().OneHourForecastDataWanted == true
                {
                    DataLoaderClimaCell().loadClimaCellData(lat: sensorLatitude, lon: sensorLongitude)
                }
                
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.05) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                print("updating +6s list entries")
                
                ProgressIndicatorShown = false
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    self.cO2Country = cO2Data.countryCode ?? ""
                    self.carbonIntensity = cO2Data.data?.carbonIntensity ?? 0
                    self.fossilFuelPercentage = cO2Data.data?.fossilFuelPercentage ?? 0
                }
                
                if ProfileEditor().AircraftDataWanted == true
                {
                    self.openSkyAircraftInBox = openSkyData.states?.count ?? 0
                }
                
                if ProfileEditor().OneHourForecastDataWanted == true
                {
                    
                    self.climaCellWeatherCode = climaCellData[0].weatherCode?.value ?? "0"
                    self.climaCellWindDirection = climaCellData[0].windDirection?.value ?? 0
                    self.climaCellFeelsLike = climaCellData[0].feelsLike?.value ?? 0
                    self.climaCellWindSpeed = climaCellData[0].windSpeed?.value ?? 0
                    self.climaCellEPAAQI = Int(round(climaCellData[0].epaAqi?.value ?? 0))
                    self.climaCellEPAPrimaryPollutant = climaCellData[0].epaPrimaryPollutant?.value ?? "0"
                    self.climaCellPollenTree = Int(climaCellData[0].pollenTree?.value ?? 0)
                    self.climaCellPollenGrass = Int(climaCellData[0].pollenGrass?.value ?? 0)
                    self.climaCellPollenWeed = Int(climaCellData[0].pollenWeed?.value ?? 0)
                }
                
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
