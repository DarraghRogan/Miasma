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
    
    @ObservedObject var telraamViewModel = TelraamViewModel()
    
    @ObservedObject var wAQIhereViewModel = WAQIhereViewModel()
    
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
    @State var uvIndex: Double = 0
    
    
    // Defining VARs for WAQI
    @State var wAQIAQI: Int = 0
    @State var fahrenheitForDisplayWAQI: String = "0"
    @State var fahrenheitForDisplayWAQIhere: String = "0"
    
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
                            .italic()
                    }
                case 0.1..<0.2:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.yellow)
                        Spacer()
                        Text("Moderate")
                            .italic()
                    }
                case 0.2..<0.3:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.orange)
                        Spacer()
                        Text("Unhealthy for Sensitive Groups")
                            .italic()
                    }
                case 0.3..<0.4:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.red)
                        Spacer()
                        Text("Unhealthy")
                            .italic()
                    }
                case 0.4..<0.6:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.purple)
                        Spacer()
                        Text("Very Unhealthy")
                            .italic()
                    }
                case 0.6..<1:
                    HStack{
                        ProgressView(configuration)
                            .accentColor(.black)
                        Spacer()
                        Text("Hazardous")
                            .italic()
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
                    .animation(.default)
                Circle()
                    .trim(from: 0, to: CGFloat(fractionCompleted))
                    .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.default)
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
                
                if ProfileEditor().AirQualityLocalToDevice == true && ProfileEditor().SensorID != "here"
                {
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("\(Image(systemName: "house")) \(wAQIViewModel.wAQIdata.city?.name ?? "◌")",
                             destination: URL(string: wAQIViewModel.wAQIdata.city?.url ?? "https://aciqn.org")!)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 1.0)
                        
                        HStack {
                            ProgressView("☁️ \(wAQIViewModel.wAQIdata.aqi ?? 0) ᴜs ᴇᴘᴀ ᴀǫɪ, ᴍᴀɪɴʟʏ \(wAQIViewModel.wAQIdata.dominentpol ?? "0")", value: Float16(wAQIViewModel.wAQIdata.aqi ?? 0), total: 500)
                                .progressViewStyle(aQIProgressBarStyle())
                                .padding(.top, 0.0)
                                .padding(.bottom, 7.0)
                                .font(.subheadline)
                                .animation(.easeInOut)

                        }
                        
                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(wAQIViewModel.wAQIdata.iaqi?.t?.v ?? 0)+17.78, total: 57)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌡")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.1f", locale: Locale.current, wAQIViewModel.wAQIdata.iaqi?.t?.v ?? 0))℃")
                                        .font(.caption)
                                    Text("/ \(self.fahrenheitForDisplayWAQI)℉")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(wAQIViewModel.wAQIdata.iaqi?.h?.v ?? 0), total: 100)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("💧")
                                        .font(.subheadline)
                                    Text("\(String(Int(wAQIViewModel.wAQIdata.iaqi?.h?.v ?? 0)))%")
                                        .font(.caption)
                                    Text("ʀᴇʟ. ʜᴜᴍ.")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(wAQIViewModel.wAQIdata.iaqi?.p?.v ?? 980)-980, total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌬️")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.1f", locale: Locale.current, wAQIViewModel.wAQIdata.iaqi?.p?.v ?? 0))mb")
                                        .font(.caption)
                                    Text("ᴘʀᴇs.")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(wAQIViewModel.wAQIdata.iaqi?.w?.v ?? 0), total: 10)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🪁")
                                        .font(.subheadline)
                                    Text("\(Int((wAQIViewModel.wAQIdata.iaqi?.w?.v ?? 0)*3.6))km/h")
                                        .font(.caption2)
                                    Text("\(Int((wAQIViewModel.wAQIdata.iaqi?.w?.v ?? 0)*2.23694))mph")
                                        .font(.caption2)
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Text("Data from \(wAQIViewModel.wAQIdata.attributions?[0].name ?? "0")")
                                .font(.caption2)
                        }
                        HStack {
                            Spacer()
                            Text("Taken on \(wAQIViewModel.wAQIdata.time?.s ?? "0")")
                                .font(.caption2)
                                .padding(.bottom, 10.0)
                        }
                        
                    }
                }
                
                if ProfileEditor().AirQualityLocalToDevice == true
                {
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("\(Image(systemName: "location.north")) \(wAQIhereViewModel.wAQIdata.city?.name ?? "◌")",
                             destination: URL(string: wAQIhereViewModel.wAQIdata.city?.url ?? "https://aciqn.org")!)
                        .font(.subheadline)
                        .padding(.bottom, 1.0)
                        .padding(.top, 5.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            ProgressView("☁️ \(wAQIhereViewModel.wAQIdata.aqi ?? 0) ᴜs ᴇᴘᴀ ᴀǫɪ, ᴍᴀɪɴʟʏ \(wAQIhereViewModel.wAQIdata.dominentpol ?? "0")", value: Float16(wAQIhereViewModel.wAQIdata.aqi ?? 0), total: 500)
                                .progressViewStyle(aQIProgressBarStyle())
                                .padding(.bottom, 7.0)
                                .font(.subheadline)
                                .animation(.easeInOut)

                        }
                        
                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(wAQIhereViewModel.wAQIdata.iaqi?.t?.v ?? 0)+17.78, total: 57)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌡")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.1f", locale: Locale.current, wAQIhereViewModel.wAQIdata.iaqi?.t?.v ?? 0))℃")
                                        .font(.caption)
                                    Text("/ \(self.fahrenheitForDisplayWAQIhere)℉")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(wAQIhereViewModel.wAQIdata.iaqi?.h?.v ?? 0), total: 100)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("💧")
                                        .font(.subheadline)
                                    Text("\(String(Int(wAQIhereViewModel.wAQIdata.iaqi?.h?.v ?? 0)))%")
                                        .font(.caption)
                                    Text("ʀᴇʟ. ʜᴜᴍ.")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(wAQIhereViewModel.wAQIdata.iaqi?.p?.v ?? 980)-980, total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌬️")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.1f", locale: Locale.current, wAQIhereViewModel.wAQIdata.iaqi?.p?.v ?? 0))mb")
                                        .font(.caption)
                                    Text("ᴘʀᴇs.")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(wAQIhereViewModel.wAQIdata.iaqi?.w?.v ?? 0), total: 10)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🪁")
                                        .font(.subheadline)
                                    Text("\(Int((wAQIhereViewModel.wAQIdata.iaqi?.w?.v ?? 0)*3.6))km/h")
                                        .font(.caption2)
                                    Text("\(Int((wAQIhereViewModel.wAQIdata.iaqi?.w?.v ?? 0)*2.23694))mph")
                                        .font(.caption2)
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Text("Data from \(wAQIhereViewModel.wAQIdata.attributions?[0].name ?? "0")")
                                .font(.caption2)
                        }
                        HStack {
                            Spacer()
                            Text("Taken on \(wAQIhereViewModel.wAQIdata.time?.s ?? "0")")
                                .font(.caption2)
                                .padding(.bottom, 2.0)
                        }
                        
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
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(fahrenheitForDisplayClimaCell), total: 100)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌡")
                                        .font(.subheadline)
                                    Text("\(String(format: "%.1f", locale: Locale.current, climaCellFeelsLike))℃")
                                        .font(.caption2)
                                    Text("/ \(fahrenheitForDisplayClimaCell)℉")
                                        .font(.caption2)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(climaCellWindSpeed), total: 10)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🪁")
                                        .font(.subheadline)
                                    Text("\(Int(climaCellWindSpeed*3.6))km/h")
                                        .font(.caption2)
                                    Text("\(Int(climaCellWindSpeed*2.23694))mph")
                                        .font(.caption2)
                                    Text("\(windDirection_acronymn)")
                                        .font(.caption2)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(climaCellEPAAQI), total: 500)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("☁️")
                                        .font(.subheadline)
                                    Text("\(climaCellEPAAQI) ᴜs ᴀǫɪ")
                                        .font(.caption2)
                                    Text("\(climaCellEPAPrimaryPollutant)")
                                        .font(.caption2)
                                }
                            }
                            
                            
                            Spacer()
                            
                            VStack{
                                Text("Pollen & UV")
                                    .font(.caption)
                                //                                .padding(.bottom, 0.5)
                                Text("🌳: \(String(Int(climaCellPollenTree))) / 5")
                                    .font(.caption)
                                    .multilineTextAlignment(.trailing)
                                Text("🌱: \(String(Int(climaCellPollenGrass))) / 5")
                                    .font(.caption)
                                    .multilineTextAlignment(.trailing)
                                Text("💐: \(String(Int(climaCellPollenWeed))) / 5")
                                    .font(.caption)
                                    .multilineTextAlignment(.trailing)
                                
                                Text("☀️: \(String(Int(uvIndex))) / 11")
                                    .font(.caption)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("\(cO2Country) ᴇʟᴇᴄᴛʀɪᴄɪᴛʏ ᴄᴏ₂",
                             destination: URL(string: "https://app.electricitymap.org/map")!)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            ProgressView("⚡️ \(Int(carbonIntensity))gCO₂eq/kWh ɢʀɪᴅ ᴄᴀʀʙᴏɴ ɪɴᴛᴇɴsɪᴛʏ", value: 100-(fossilFuelPercentage), total: 100)
                                .accentColor(.green)
                                .padding(.top, 0.5)
                                .padding(.bottom, 4.0)
                                .font(.subheadline)
                                .animation(.easeInOut)

                        }
                        
                    }
                    .ignoresSafeArea()
                    
                }
                
                
                if ProfileEditor().TelraamDataWanted == true
                {
                    
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("ᴛᴇʟʀᴀᴀᴍ ᴛʀᴀғғɪᴄ (ʟᴀsᴛ ᴅᴀʏʟɪɢʜᴛ ʜᴏᴜʀ)",
                             destination: URL(string: "https://www.telraam.net/en/location/\(ProfileEditor().segmentID)")!)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.pedestrian ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🚶")
                                        .font(.title)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.pedestrian ?? 0))))")
                                        .font(.subheadline)

                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.bike ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🚲")
                                        .font(.title)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.bike ?? 0))))")
                                        .font(.subheadline)

                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.car ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🚗")
                                        .font(.title)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.car ?? 0))))")
                                        .font(.subheadline)

                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.lorry ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🚚")
                                        .font(.title)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.lorry ?? 0))))")
                                        .font(.subheadline)

                                }
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
                
                if ProfileEditor().ShowWelcomeText == false
                {
                    
                }
                else
                {
                    VStack{
                        Text("\(Image(systemName: "hand.wave")) Welcome to Miasma")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 1.5)
                            .padding(.top, 2.0)
                        Text("""
By default the air quality & other data for the weather measurement station closest to your iPhone's coarse location (denoted by \(Image(systemName: "location.north"))) is shown.
You can choose to additonally show a particular sensor (denoted by \(Image(systemName: "house"))) in the preferences menu \(Image(systemName: "gearshape.fill")) (top right of screen).
You can also show factors that influence air quality like electrical grid carbon intensity, road traffic data, and receive a 1 hour pollution & weather forecast.
Tapping any data tile will give deeper information. And pulling and releasing the data tiles will refresh their data.
Best wishes in using the app, and wishing you have good air quality. Darragh
""")
                        .font(.caption)
                        .font(Font.body.leading(.loose))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineSpacing(4)
                        Button("Dismiss Welcome text", role: .destructive) {
                        action: do {
                            AppDelegate().defaults.set(false, forKey: "ShowWelcomeText")
                            self.updateListEntry()
                        }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, 2.0)
                    }
                }
                
                
                
                //                Button("🔄", action: {
                //                    updateListEntry()
                //                } )
                //                .font(.title)
                //                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
        }
        .refreshable {
            self.updateListEntry()
        }
        .onAppear() {
            self.updateListEntry()
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
        
        if ProfileEditor().AirQualityLocalToDevice == true
        {
            wAQIhereViewModel.getWAQIhere()
            wAQIhereViewModel.objectWillChange.send()
        }
        
        if ProfileEditor().TelraamDataWanted == true
        {
            telraamViewModel.getTelraam()
            telraamViewModel.objectWillChange.send()
        }
        
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
                    AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 51 && wAQIAQI < 100:
                    AppDelegate().defaults.set("🟡", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 101 && wAQIAQI < 200:
                    AppDelegate().defaults.set("🟠", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 201 && wAQIAQI < 300:
                    AppDelegate().defaults.set("🔴", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 301 && wAQIAQI < 400:
                    AppDelegate().defaults.set("🟣", forKey: "PreviousStateForNotification")
                case _ where wAQIAQI >= 400:
                    AppDelegate().defaults.set("🟤", forKey: "PreviousStateForNotification")
                default:
                    AppDelegate().defaults.set("⚪", forKey: "PreviousStateForNotification")
                }
                
                self.fahrenheitForDisplayWAQI = calculateFahrenheit(celcius: wAQIViewModel.wAQIdata.iaqi?.t?.v ?? 0)
                
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    DataLoaderCO2().loadCO2Data(lat: String(sensorLatitude), lon: String(sensorLongitude))
                }
                
                if ProfileEditor().AirQualityLocalToDevice == true
                {
                    self.fahrenheitForDisplayWAQIhere = calculateFahrenheit(celcius: wAQIhereViewModel.wAQIdata.iaqi?.t?.v ?? 0)
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
                
                
                // a little protection from when over API calls to ClimaCell, a la : https://stackoverflow.com/questions/25976909/swift-array-check-if-an-index-exists
                var isIndexValid: Bool = false
                if 2 < climaCellData.data?.timelines?[0].intervals?.count ?? 0 {
                    isIndexValid = true
                } else {
                    
                }
                
                if ProfileEditor().OneHourForecastDataWanted == true && isIndexValid == true
                {
                    
                    
                    //                    self.climaCellWeatherCode = ClimaCellWeatherCodeText
                    self.climaCellWindDirection = climaCellData.data?.timelines?[0].intervals?[1].values?.windDirection ?? 0
                    self.climaCellFeelsLike = climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0
                    self.climaCellWindSpeed = climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0
                    self.climaCellEPAAQI = climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0
                    //                    self.climaCellEPAPrimaryPollutant = ClimaCellPrimaryPollutant
                    self.climaCellPollenTree = Int(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0)
                    self.climaCellPollenGrass = Int(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0)
                    self.climaCellPollenWeed = Int(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0)
                    self.uvIndex = climaCellData.data?.timelines?[0].intervals?[1].values?.uvIndex ?? 0
                    
                    let windDirection = climaCellData.data?.timelines?[0].intervals?[1].values?.windDirection ?? 0
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
                    
                    let climaCellPrimaryPollutant = climaCellData.data?.timelines?[0].intervals?[1].values?.epaPrimaryPollutant ?? 0
                    var ClimaCellPrimaryPollutantText: String
                    switch climaCellPrimaryPollutant {
                    case _ where climaCellPrimaryPollutant == 0:
                        climaCellEPAPrimaryPollutant = "PM₂.₅"
                    case _ where climaCellPrimaryPollutant == 1:
                        climaCellEPAPrimaryPollutant = "PM₁₀"
                    case _ where climaCellPrimaryPollutant == 2:
                        climaCellEPAPrimaryPollutant = "O₃"
                    case _ where climaCellPrimaryPollutant == 3:
                        climaCellEPAPrimaryPollutant = "NO₂"
                    case _ where climaCellPrimaryPollutant == 4:
                        climaCellEPAPrimaryPollutant = "CO"
                    case _ where climaCellPrimaryPollutant == 5:
                        ClimaCellPrimaryPollutantText = "SO₂"
                    default:
                        climaCellEPAPrimaryPollutant = "Unknown"
                    }
                    
                    
                    let climaCellWeatherCodeNumeric = climaCellData.data?.timelines?[0].intervals?[1].values?.weatherCode ?? 0
                    switch climaCellWeatherCodeNumeric {
                    case _ where climaCellWeatherCodeNumeric == 1000:
                        climaCellWeatherCode = "Clear"
                    case _ where climaCellWeatherCodeNumeric == 1001:
                        climaCellWeatherCode = "Cloudy"
                    case _ where climaCellWeatherCodeNumeric == 1100:
                        climaCellWeatherCode = "Mostly Clear"
                    case _ where climaCellWeatherCodeNumeric == 1101:
                        climaCellWeatherCode = "Partly Cloudy"
                    case _ where climaCellWeatherCodeNumeric == 1102:
                        climaCellWeatherCode = "Mostly Cloudy"
                    case _ where climaCellWeatherCodeNumeric == 2000:
                        climaCellWeatherCode = "Fog"
                    case _ where climaCellWeatherCodeNumeric == 2100:
                        climaCellWeatherCode = "Light Fog"
                    case _ where climaCellWeatherCodeNumeric == 3000:
                        climaCellWeatherCode = "Light Wind"
                    case _ where climaCellWeatherCodeNumeric == 3001:
                        climaCellWeatherCode = "Wind"
                    case _ where climaCellWeatherCodeNumeric == 3002:
                        climaCellWeatherCode = "Strong Wind"
                    case _ where climaCellWeatherCodeNumeric == 4000:
                        climaCellWeatherCode = "Drizzle"
                    case _ where climaCellWeatherCodeNumeric == 4001:
                        climaCellWeatherCode = "Rain"
                    case _ where climaCellWeatherCodeNumeric == 4200:
                        climaCellWeatherCode = "Light Rain"
                    case _ where climaCellWeatherCodeNumeric == 4201:
                        climaCellWeatherCode = "Heavy Rain"
                    case _ where climaCellWeatherCodeNumeric == 5000:
                        climaCellWeatherCode = "Snow"
                    case _ where climaCellWeatherCodeNumeric == 5001:
                        climaCellWeatherCode = "Flurries"
                    case _ where climaCellWeatherCodeNumeric == 5100:
                        climaCellWeatherCode = "Light Snow"
                    case _ where climaCellWeatherCodeNumeric == 5101:
                        climaCellWeatherCode = "Heavy Snow"
                    case _ where climaCellWeatherCodeNumeric == 6000:
                        climaCellWeatherCode = "Freezing Drizzle"
                    case _ where climaCellWeatherCodeNumeric == 6001:
                        climaCellWeatherCode = "Freezing Rain"
                    case _ where climaCellWeatherCodeNumeric == 6200:
                        climaCellWeatherCode = "Light Freezing Rain"
                    case _ where climaCellWeatherCodeNumeric == 6201:
                        climaCellWeatherCode = "Heavy Freezing Rain"
                    case _ where climaCellWeatherCodeNumeric == 7000:
                        climaCellWeatherCode = "Ice Pellets"
                    case _ where climaCellWeatherCodeNumeric == 7101:
                        climaCellWeatherCode = "Heavy Ice Pellets"
                    case _ where climaCellWeatherCodeNumeric == 7102:
                        climaCellWeatherCode = "Light Ice Pellets"
                    case _ where climaCellWeatherCodeNumeric == 8000:
                        climaCellWeatherCode = "Thunderstorm"
                    default:
                        climaCellWeatherCode = "Unknown"
                    }
                    
                    // Calculate Farenheit from Celcius for ClimaCell
                    celciusForCalculationClimaCell = climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0
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
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentViewWAQI()
                .environment(\.sizeCategory, .extraSmall)
            
            ContentViewWAQI()
            
            ContentViewWAQI()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
    }
    
}
