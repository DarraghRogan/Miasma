//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import CoreLocation

public struct ContentViewWAQI: View {
    
    // Heavly implementing combine per https://engineering.nodesagency.com/categories/ios/2020/03/16/Combine-networking-with-a-hint-of-swiftUI
    
    @ObservedObject var wAQIViewModel = WAQIViewModel()
    
    @State var ProgressIndicatorShown = true
    
    // the default location has top-notch food :-) (pork with fish sauce for the win)
    @State var sensorLatitude: Double = 53.3412
    @State var sensorLongitude: Double = -6.2507
    @State var locationCoordinate = CLLocationCoordinate2DMake(53.3412, -6.2507)
    
    // Defining VARs for CO2 Signal
    //    @State var fossilFuelPercentage_visual: String = "[__________]"
    @State var cO2Country: String = "◌"
    @State var carbonIntensity: Double = 0.0
    @State var fossilFuelPercentage: Double = 0.0
    
    //    @State var openSkyAircraftInBox: Int = 0
    
    // Defining VARs for ClimaCell
    @State var windDirection_acronymn: String = "___"
    @State var climaCellWeatherCode: String = "◌"
    @State var climaCellWindDirection: Double = 0.0
    @State var climaCellFeelsLike: Double = 0.0
    @State var climaCellWindSpeed: Double = 0.0
    @State var climaCellEPAAQI: Int = 0
    @State var climaCellEPAPrimaryPollutant: String = "◌"
    @State var climaCellPollenTree: Int = 0
    @State var climaCellPollenGrass: Int = 0
    @State var climaCellPollenWeed: Int = 0
    @State var fahrenheitForDisplayClimaCell: String = "0"
    @State var celciusForCalculationClimaCell: Double = 0

    
    // Defining VARs for WAQI
    @State var wAQIAQI: Int = 0
    @State var wAQIAQIColourButton: String = "[______]"
    @State var fahrenheitForDisplayWAQI: String = "0"
    
    // Defining the Progress Bar Styles
    struct aQIProgressBarStyle: ProgressViewStyle {
        func makeBody(configuration: Configuration) -> some View {
            
            if let fractionCompleted = configuration.fractionCompleted{
                switch fractionCompleted {
                case 0..<0.1:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.green)
                        Spacer()
                        Text("Good")
                    }
                case 0.1..<0.2:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.yellow)
                        Spacer()
                        Text("Moderate")
                    }
                case 0.2..<0.3:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.orange)
                        Spacer()
                        Text("Unhealthy for Sensitive Groups")
                    }
                case 0.3..<0.4:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.red)
                        Spacer()
                        Text("Unhealthy")
                    }
                case 0.4..<0.6:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.purple)
                        Spacer()
                        Text("Very Unhealthy")
                    }
                case 0.6..<1:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.black)
                        Spacer()
                        Text("Hazardous")
                    }
                default:
                    ProgressView(configuration)
                        .accentColor(.gray)
                }
            }
        }
    }
    
    struct GaugeProgressStyle: ProgressViewStyle {
        var strokeColor = Color.purple
        var nonStrokeColor = (Color(.systemGray5))
        var strokeWidth = 5.0
        
        func makeBody(configuration: Configuration) -> some View {
            let fractionCompleted = configuration.fractionCompleted ?? 0
            
            return ZStack {
                Circle()
                    .trim(from: 0, to: 100)
                    .stroke(nonStrokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Circle()
                    .trim(from: 0, to: CGFloat(fractionCompleted))
                    .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
        }
    }
    
    public var body: some View {
        
        VStack
        {
            
            MapView(coordinate: locationCoordinate)
                //                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
                .opacity(0.7)
                .overlay((CircleImage()
                            .offset(x: 0, y: 0)), alignment: .center)
                .overlay(Text("M \(AppDelegate().defaults.object(forKey:"PreviousStateForNotification") as? String ?? String())")
                            .font(.largeTitle)
                )
            
            List
            {
                
                VStack{
                    if ProgressIndicatorShown == true{
                        ProgressView()
                    }
                    Link("\(wAQIViewModel.wAQIdata.city?.name ?? "◌")",
                         destination: URL(string: wAQIViewModel.wAQIdata.city?.url ?? "https://aciqn.org")!)
                        .font(.headline)

                    HStack {
                        ProgressView("☁️ \(wAQIViewModel.wAQIdata.aqi ?? 0) ᴜs ᴇᴘᴀ ᴀǫɪ, ᴘʀɪᴍᴀʀɪʟʏ \(wAQIViewModel.wAQIdata.dominentpol ?? "0")", value: Float16(wAQIViewModel.wAQIdata.aqi ?? 0), total: 500)
                            .progressViewStyle(aQIProgressBarStyle())
                            .padding(.top, 0.5)
                            .padding(.bottom, 7.0)
                            .onAppear() {
                                self.updateListEntry()
                            }

                    }
                    
                    HStack {
                        ZStack{
                            ProgressView("", value: Float16(wAQIViewModel.wAQIdata.iaqi?.t?.v ?? 0)+17.78, total: 60)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                                                        .padding(.bottom, 4.0)
                            VStack{
                                Text("🌡")
                                    .font(.title)
                                Text("\(String(wAQIViewModel.wAQIdata.iaqi?.t?.v ?? 0))℃")
                                Text("/ \(self.fahrenheitForDisplayWAQI)℉")
                            }
                        }
                        .onAppear() {
                            self.updateListEntry()
                        }
                        Spacer()
                        ZStack{
                            ProgressView("", value: Float16(wAQIViewModel.wAQIdata.iaqi?.h?.v ?? 0), total: 100)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                                                        .padding(.bottom, 4.0)
                            VStack{
                                Text("💧")
                                    .font(.title)
                                Text("\(String(wAQIViewModel.wAQIdata.iaqi?.h?.v ?? 0))%")
                                Text("ʀᴇʟ. ʜᴜᴍ.")
                            }
                        }
                        .onAppear() {
                            self.updateListEntry()
                        }
                        Spacer()
                        ZStack{
                            ProgressView("", value: Float16(wAQIViewModel.wAQIdata.iaqi?.p?.v ?? 980)-980, total: 50)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                                                        .padding(.bottom, 4.0)
                            VStack{
                                Text("🌬️")
                                    .font(.title)
                                Text("\(String(wAQIViewModel.wAQIdata.iaqi?.p?.v ?? 0))mb")
                                Text("ᴘʀᴇs.")
                            }
                        }
                        .onAppear() {
                            self.updateListEntry()
                        }
                }
                    
                    HStack {
                        Spacer()
                        Text("\(wAQIViewModel.wAQIdata.attributions?[0].name ?? "0")")
                            .font(.footnote)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    HStack {
                        Spacer()
                        Text("\(wAQIViewModel.wAQIdata.time?.s ?? "0"); User Selected Station (WAQI) ⇀")
                            .font(.footnote)
                            .padding(.bottom, 10.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    
                }
                
                HStack{
                    if ProfileEditor().ElectricalConsumptionDataWanted == true
                    {
                        
                        VStack{
                            if ProgressIndicatorShown == true{
                                ProgressView()
                            }
                            Link("\(cO2Country) ᴇʟᴇᴄᴛʀɪᴄɪᴛʏ ᴄᴏ₂",
                                 destination: URL(string: "https://www.electricitymap.org/")!)
                                .padding(.top, 5.0)
                                .font(.headline)
                                .onAppear() {
                                    self.updateListEntry()
                                }
                            
                            
                            HStack {
                                ProgressView("⚡️ \(Int(carbonIntensity))gCO₂eq/kWh ɢʀɪᴅ ᴄᴀʀʙᴏɴ ɪɴᴛᴇɴsɪᴛʏ", value: 100-(fossilFuelPercentage), total: 100)
                                    .accentColor(.green)
                                    .padding(.top, 0.5)
                                    .padding(.bottom, 4.0)
                                    .onAppear() {
                                        self.updateListEntry()
                                    }
                            }
                            
                            HStack {
                                Spacer()
                                Text("(CO₂ Signal) ⇀")
                                    .font(.footnote)
                                    .padding(.bottom, 5.0)
                                
                            }
                            
                        }
                        .ignoresSafeArea()
                        
                    }
                }
                
                
                if ProfileEditor().OneHourForecastDataWanted == true
                {
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("ᴏɴᴇ ʜᴏᴜʀ ꜰᴏʀᴇᴄᴀsᴛ: \(climaCellWeatherCode)",
                             destination: URL(string: "https://www.tomorrow.io/weather/")!)
                            .padding(.top, 8.0)
                            .font(.headline)
                        
                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(fahrenheitForDisplayClimaCell), total: 100)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 100, height: 100)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌡")
                                        .font(.title)
                                    Text("\(String(format: "%.1f", locale: Locale.current, climaCellFeelsLike))℃")
                                    Text("/ \(fahrenheitForDisplayClimaCell)℉")
                                }
                            }
                            .onAppear() {
                                self.updateListEntry()
                            }
                            
                            Spacer()
                            ZStack{
                                ProgressView("", value: Float16(climaCellWindSpeed), total: 10)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 100, height: 100)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🪁")
                                        .font(.title)
                                    Text("\(Int(climaCellWindSpeed*3.6))km/h / \(Int(climaCellWindSpeed*2.23694))mph")
                                        .font(.caption)
                                    Text("ғʀᴏᴍ \(windDirection_acronymn)")
                                        .font(.caption)
                                }
                            }
                            .onAppear() {
                                self.updateListEntry()
                            }
                            Spacer()
                            ZStack{
                                ProgressView("", value: Float16(climaCellEPAAQI), total: 500)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 100, height: 100)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("☁️")
                                        .font(.title)
                                    Text("\(climaCellEPAAQI) ᴀǫɪ ᴜs ᴇᴘᴀ")
                                        .font(.caption)
                                    Text("ᴘʀɪᴍᴀʀɪʟʏ \(climaCellEPAPrimaryPollutant)")
                                        .font(.caption)
                                }
                            }
                            .onAppear() {
                                self.updateListEntry()
                            }
                        }
                        
                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(climaCellPollenTree), total: 5)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 100, height: 100)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌳")
                                        .font(.title)
                                    Text("Pollen")
                                }
                            }
                            .onAppear() {
                                self.updateListEntry()
                            }
                            
                            Spacer()
                            ZStack{
                                ProgressView("", value: Float16(climaCellPollenGrass), total: 5)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 100, height: 100)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌱")
                                        .font(.title)
                                    Text("Pollen")
                                }
                            }
                            .onAppear() {
                                self.updateListEntry()
                            }
                            Spacer()
                            ZStack{
                                ProgressView("", value: Float16(climaCellPollenWeed), total: 5)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 100, height: 100)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("💐")
                                        .font(.title)
                                    Text("Pollen")
                                }
                            }
                            .onAppear() {
                                self.updateListEntry()
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Text("(Tomorrow.io) ⇀")
                                .font(.footnote)
                                .padding(.bottom, 5.0)
                            
                        }
                        
                        
                    }
                    .ignoresSafeArea()
                    
                }
                
                
                //                if ProfileEditor().ElectricalConsumptionDataWanted == true
                //                {
                //
                //                    VStack{
                //                        if ProgressIndicatorShown == true{
                //                            ProgressView()
                //                        }
                //                        Link("Electricity Consumption (CO₂ Signal) ⇀",
                //                             destination: URL(string: "https://www.electricitymap.org/")!)
                //                            .padding(.top, 8.0)
                //                            .font(.headline)
                //
                //                        HStack {
                //                            Text("🌍")
                //                            Spacer()
                //                            Text("\(cO2Country) Carbon Intensity is \(String(format: "%.1f", locale: Locale.current, carbonIntensity))gCO₂eq/kWh")
                //                                .font(.footnote)
                //                                .padding(.top, 5.0)
                //                                .onAppear() {
                //                                    self.updateListEntry()
                //                                }
                //                        }
                //                        HStack {
                //                            Text("⚡️")
                //                            Spacer()
                //                            Text("\(String(format: "%.1f", locale: Locale.current,(100-fossilFuelPercentage)))% Low CO₂")
                //                                .font(.footnote)
                //                                .lineLimit(1)
                //                                .padding(.top, 5.0)
                //                                .onAppear() {
                //                                    self.updateListEntry()
                //                                }
                //                        }
                //                    }
                //
                //                }
                //
                //                //                if ProfileEditor().AircraftDataWanted == true
                //                //                {
                //                //
                //                //                    VStack{
                //                //                        if ProgressIndicatorShown == true{
                //                //                            ProgressView()
                //                //                        }
                //                //                        Link("Aircraft Overhead (OpenSky) ⇀",
                //                //                             destination: URL(string: "https://opensky-network.org/")!)
                //                //                            .padding(.top, 8.0)
                //                //                            .font(.headline)
                //                //
                //                //                        HStack {
                //                //                            Text("✈️")
                //                //                            Spacer()
                //                //                            Text("\(openSkyAircraftInBox) aircraft ±1° over Air Quality sensor")
                //                //                                .font(.footnote)
                //                //                                .padding(.top, 5.0)
                //                //                                .onAppear() {
                //                //                                    self.updateListEntry()
                //                //                                }
                //                //                        }
                //                //
                //                //                    }
                //                //
                //                //                }
                //
                //                if ProfileEditor().OneHourForecastDataWanted == true
                //                {
                //
                //                    VStack{
                //                        if ProgressIndicatorShown == true{
                //                            ProgressView()
                //                        }
                //                        Link("1 Hour Forecast (ClimaCell Nearcast)⇀",
                //                             destination: URL(string: "itms-apps://itunes.apple.com/app/id1443325509")!)
                //                            .padding(.top, 8.0)
                //                            .font(.headline)
                //
                //                        HStack {
                //                            Text("🌦")
                //                            Spacer()
                //                            Text("Will be \(climaCellWeatherCode), feel like \(String(format: "%.1f", locale: Locale.current, climaCellFeelsLike))℃ / \(calculateFahrenheit(celcius: climaCellFeelsLike))℉, with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, climaCellWindSpeed))m/s / \(Int(climaCellWindSpeed*3.6))km/h / \(Int(climaCellWindSpeed*2.23694))mph")
                //                                .font(.footnote)
                //                                .padding(.top, 5.0)
                //                                .onAppear() {
                //                                    self.updateListEntry()
                //                                }
                //                        }
                //                        HStack {
                //                            Text("☁️")
                //                            Spacer()
                //                            Text("Air Quality will be \(climaCellEPAAQI) US EPA PM₂.₅ AQI, with primary pollutant of: \(climaCellEPAPrimaryPollutant)")
                //                                .font(.footnote)
                //                                .padding(.top, 5.0)
                //                                .onAppear() {
                //                                    self.updateListEntry()
                //                                }
                //                        }
                //                        HStack {
                //                            Text("🌳")
                //                            Spacer()
                //                            Text("Pollen Index [0-5] will be: Trees: \(climaCellPollenTree), Grass: \(climaCellPollenGrass), Weeds: \(climaCellPollenWeed)")
                //                                .font(.footnote)
                //                                .padding(.top, 5.0)
                //                                .onAppear() {
                //                                    self.updateListEntry()
                //                                }
                //                        }
                //                    }
                //
                //                }
                Button("🔄", action: {
                    updateListEntry()
                } )
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
            
        }
        
    }
    
    
    
    func calculateFahrenheit(celcius: Double) -> String {
        var fahrenheit: Double
        fahrenheit = (celcius  * 9 / 5) + 32
        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
        return fahrenheitRoundedString
    }
    
    public func updateListEntry() {
        
        ProgressIndicatorShown = true
        
        wAQIViewModel.getWAQI()
        wAQIViewModel.objectWillChange.send()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.05) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                print("running +3s data loaders")
                
                ProgressIndicatorShown = true
                
                // Get Latitude & longitude to feed into other APIs
                self.locationCoordinate = CLLocationCoordinate2DMake(wAQIViewModel.wAQIdata.city?.geo[0] ?? 0, wAQIViewModel.wAQIdata.city?.geo[1] ?? 0)
                
                self.sensorLatitude = wAQIViewModel.wAQIdata.city?.geo[0] ?? 0
                self.sensorLongitude = wAQIViewModel.wAQIdata.city?.geo[1] ?? 0
                
                self.locationCoordinate = CLLocationCoordinate2DMake(wAQIViewModel.wAQIdata.city?.geo[0] ?? 0, wAQIViewModel.wAQIdata.city?.geo[1] ?? 0)
                
                self.sensorLatitude = wAQIViewModel.wAQIdata.city?.geo[0] ?? 0
                self.sensorLongitude = wAQIViewModel.wAQIdata.city?.geo[1] ?? 0
                
                
                // Create AQI images
                wAQIAQI = wAQIViewModel.wAQIdata.aqi ?? 0
                switch (wAQIAQI) {
                case _ where wAQIAQI >= 0 && wAQIAQI < 50:
                    wAQIAQIColourButton = "[🟢_____]"
                    AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 51 && wAQIAQI < 100:
                    wAQIAQIColourButton = "[_🟡____]"
                    AppDelegate().defaults.set("🟡", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 101 && wAQIAQI < 200:
                    wAQIAQIColourButton = "[__🟠___]"
                    AppDelegate().defaults.set("🟠", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 201 && wAQIAQI < 300:
                    wAQIAQIColourButton = "[___🔴__]"
                    AppDelegate().defaults.set("🔴", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 301 && wAQIAQI < 400:
                    wAQIAQIColourButton = "[____🟣_]"
                    AppDelegate().defaults.set("🟣", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 400:
                    wAQIAQIColourButton = "[_____🟤]"
                    AppDelegate().defaults.set("🟤", forKey: "PreviousStateForNotification")
                default:
                    wAQIAQIColourButton = "[      ]"
                }
                
                self.fahrenheitForDisplayWAQI = calculateFahrenheit(celcius: wAQIViewModel.wAQIdata.iaqi?.t?.v ?? 0)
                
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    DataLoaderCO2().loadCO2Data(lat: String(sensorLatitude), lon: String(sensorLongitude))
                }
                
                //                if ProfileEditor().AircraftDataWanted == true
                //                {
                //                    DataLoaderOpenSky().loadOpenSkyData(lamin: sensorLatitude-1, lomin: sensorLongitude-1, lamax: sensorLatitude+1, lomax: sensorLongitude+1)
                //                }
                
                if ProfileEditor().OneHourForecastDataWanted == true
                {
                    DataLoaderClimaCell().loadClimaCellData(lat: sensorLatitude, lon: sensorLongitude)
//                    print("requested ClimaCell")
                }
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.05) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                print("updating +8s list entries")
                
                ProgressIndicatorShown = false
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    self.cO2Country = cO2Data.countryCode ?? ""
                    self.carbonIntensity = cO2Data.data?.carbonIntensity ?? 0
                    
                    self.fossilFuelPercentage = cO2Data.data?.fossilFuelPercentage ?? 0
                    //                switch (fossilFuelPercentage) {
                    //                case _ where fossilFuelPercentage > 0 && fossilFuelPercentage < 5:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️♻️]"
                    //                case _ where fossilFuelPercentage > 5 && fossilFuelPercentage < 15:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️🦖]"
                    //                case _ where fossilFuelPercentage > 15 && fossilFuelPercentage < 25:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️🦖🦖]"
                    //                case _ where fossilFuelPercentage > 25 && fossilFuelPercentage < 35:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️🦖🦖🦖]"
                    //                case _ where fossilFuelPercentage > 35 && fossilFuelPercentage < 45:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️🦖🦖🦖🦖]"
                    //                case _ where fossilFuelPercentage > 45 && fossilFuelPercentage < 55:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️🦖🦖🦖🦖🦖]"
                    //                case _ where fossilFuelPercentage > 55 && fossilFuelPercentage < 65:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️🦖🦖🦖🦖🦖🦖]"
                    //                case _ where fossilFuelPercentage > 65 && fossilFuelPercentage < 75:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️♻️🦖🦖🦖🦖🦖🦖🦖]"
                    //                case _ where fossilFuelPercentage > 75 && fossilFuelPercentage < 85:
                    //                    self.fossilFuelPercentage_visual = "[♻️♻️🦖🦖🦖🦖🦖🦖🦖🦖]"
                    //                case _ where fossilFuelPercentage > 85 && fossilFuelPercentage < 95:
                    //                    self.fossilFuelPercentage_visual = "[♻️🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    //                case _ where fossilFuelPercentage > 95:
                    //                    self.fossilFuelPercentage_visual = "[🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    //                default:
                    //                    fossilFuelPercentage_visual = "[          ]"
                    //                }
                    
                }
                //
                //                if ProfileEditor().AircraftDataWanted == true
                //                {
                //                    self.openSkyAircraftInBox = openSkyData.states?.count ?? 0
                //                }
                
                // a little protection fro when over API calls to ClimaCell, a la : https://stackoverflow.com/questions/25976909/swift-array-check-if-an-index-exists
                var isIndexValid: Bool = false
                if 2 < climaCellData.count {
                    isIndexValid = true
                } else {
                    
                }
                
                if ProfileEditor().OneHourForecastDataWanted == true && isIndexValid == true
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
                    
                    let windDirection = climaCellData[0].windDirection?.value ?? 0
                    // directiosn from http://www.angelfire.com/space/one1/cal.html
                    switch (windDirection) {
                    case _ where windDirection < 45:
                        self.windDirection_acronymn = "NNE"
                    case _ where windDirection > 45 && windDirection < 90:
                        self.windDirection_acronymn = "ENE"
                    case _ where windDirection > 90 && windDirection < 135:
                        self.windDirection_acronymn = "ESE"
                    case _ where windDirection > 135 && windDirection < 180:
                        self.windDirection_acronymn = "SSE"
                    case _ where windDirection > 180 && windDirection < 225:
                        self.windDirection_acronymn = "SSW"
                    case _ where windDirection > 225 && windDirection < 270:
                        self.windDirection_acronymn = "WSW"
                    case _ where windDirection > 270 && windDirection < 315:
                        self.windDirection_acronymn = "WNW"
                    case _ where windDirection > 315:
                        self.windDirection_acronymn = "NNW"
                    default:
                        self.windDirection_acronymn = ""
                        
                    }
                    
                    // Calculate Farenheit from Celcius for ClimaCell
                    celciusForCalculationClimaCell = climaCellData[0].feelsLike?.value ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius  * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    self.fahrenheitForDisplayClimaCell = calculateFahrenheit(celcius: celciusForCalculationClimaCell)
                    
                }
            }
        }
    }
    
    
    struct ContentViewWAQI_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
                    .environment(\.sizeCategory, .small)
            }
        }
    }
    
}
