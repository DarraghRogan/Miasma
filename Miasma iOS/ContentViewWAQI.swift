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
    @State var fahrenheitForDisplayClimaCell: String = "◌"
    @State var celciusForCalculationClimaCell: Double = 0
    @State var uvIndex: Double = 0
    @State var precipitationProbability: Int = 0
    
    
    // Defining VARs for WAQI
    @State var wAQIAQI: Int = 0
    @State var fahrenheitForDisplayWAQI: String = "◌"
    @State var fahrenheitForDisplayWAQIhere: String = "◌"
    
    // Defining VARs for DailyAtmosphericCO2 & GlobalWarming
    @State var cO2PPMLastYearOnYearDeltaPercentage: Double = 0
    @State var cO2PPMAnnualAverageSinceUNEPMilestoneDeltaPercentage: Double = 0
    @State var dailyAtmosphericCO2Data365Last: String = "◌"
    
    @State var globalWarmingLastYearOnYearDeltaPercentage: Double = 0
    @State var globalWarmingLastValue: String = "◌"
    @State var globalWarmingLastTime: String = "◌"
    
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
                        Link("\(Image(systemName: "house")) \(wAQIViewModel.wAQIdata.city?.name ?? "◌") ᴀɪʀ ǫᴜᴀʟɪᴛʏ",
                             destination: URL(string: wAQIViewModel.wAQIdata.city?.url ?? "https://aciqn.org")!)
                        .font(.subheadline)
                        .padding(.bottom, 1.0)
                        .padding(.top, 8.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            ProgressView("""
                        \(wAQIViewModel.wAQIdata.aqi ?? 0) ᴜs ᴇᴘᴀ ᴀǫɪ
                        ᴍᴀɪɴʟʏ \(wAQIViewModel.wAQIdata.dominentpol ?? "0")
                        """, value: Float16(wAQIViewModel.wAQIdata.aqi ?? 0), total: 500)
                            .progressViewStyle(aQIProgressBarStyle())
                            .padding(.bottom, 7.0)
                            .font(.subheadline)
                            .animation(.easeInOut)
                            Divider()
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
                            
                        }
                        
                        HStack {
                            Spacer()
                            Text("Data from \(wAQIViewModel.wAQIdata.attributions?[0].name ?? "0")")
                                .font(.caption2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        HStack {
                            Spacer()
                            Text("Taken on \(wAQIViewModel.wAQIdata.time?.s ?? "0")")
                                .font(.caption2)
                                .padding(.bottom, 2.0)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                if ProfileEditor().AirQualityLocalToDevice == true
               {
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("\(Image(systemName: "location.north")) \(wAQIhereViewModel.wAQIdata.city?.name ?? "◌") ᴀɪʀ ǫᴜᴀʟɪᴛʏ",
                             destination: URL(string: wAQIhereViewModel.wAQIdata.city?.url ?? "https://aciqn.org")!)
                        .font(.subheadline)
                        .padding(.bottom, 1.0)
                        .padding(.top, 8.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            ProgressView("""
                        \(wAQIhereViewModel.wAQIdata.aqi ?? 0) ᴜs ᴇᴘᴀ ᴀǫɪ
                        ᴍᴀɪɴʟʏ \(wAQIhereViewModel.wAQIdata.dominentpol ?? "0")
                        """, value: Float16(wAQIhereViewModel.wAQIdata.aqi ?? 0), total: 500)
                            .progressViewStyle(aQIProgressBarStyle())
                            .padding(.bottom, 7.0)
                            .font(.subheadline)
                            .animation(.easeInOut)
                            Divider()
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
                            
                        }
                        
                        HStack {
                            Spacer()
                            Text("Data from \(wAQIhereViewModel.wAQIdata.attributions?[0].name ?? "0")")
                                .font(.caption2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        HStack {
                            Spacer()
                            Text("Taken on \(wAQIhereViewModel.wAQIdata.time?.s ?? "0")")
                                .font(.caption2)
                                .padding(.bottom, 2.0)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                
                if ProfileEditor().OneHourForecastDataWanted == true
                {
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("\(Image(systemName: "binoculars")) 1 ʜᴏᴜʀ ꜰᴏʀᴇᴄᴀsᴛ: \(climaCellWeatherCode)",
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
                            
                        }
                        
                        HStack {
                            
                            ZStack{
                                ProgressView("", value: Float16(climaCellPollenTree+climaCellPollenGrass+climaCellPollenWeed), total: 15)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 8.0)
                                VStack{
                                    Text("🌱")
                                        .font(.subheadline)
                                    Text("\(climaCellPollenTree+climaCellPollenGrass+climaCellPollenWeed) / 15")
                                        .font(.caption2)
                                    Text("ᴘᴏʟʟᴇɴ")
                                        .font(.caption2)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(uvIndex), total: 11)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 8.0)
                                VStack{
                                    Text("☀️")
                                        .font(.subheadline)
                                    Text("\(Int(uvIndex)) / 11")
                                        .font(.caption2)
                                    Text("UV Iɴᴅᴇx")
                                        .font(.caption2)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(precipitationProbability), total: 100)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 8.0)
                                VStack{
                                    Text("🌧️")
                                        .font(.subheadline)
                                    Text("\(precipitationProbability)%")
                                        .font(.caption2)
                                    Text("ᴘʀᴇᴄɪᴘ.")
                                        .font(.caption2)
                                    Text("ᴘʀᴏʙ.")
                                        .font(.caption2)
                                }
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
                        Link("\(Image(systemName: "bolt")) \(cO2Country) ᴇʟᴇᴄᴛʀɪᴄɪᴛʏ ʀᴇɴᴇᴡᴀʙʟᴇs",
                             destination: URL(string: "https://app.electricitymap.org/map")!)
                        //                            .padding(.top, 5.0)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            ProgressView("⚡️ \(Int(carbonIntensity))gCO₂eq/kWh ɢʀɪᴅ ᴄᴀʀʙᴏɴ ɪɴᴛᴇɴsɪᴛʏ", value: 100-(fossilFuelPercentage), total: 100)
                                .accentColor(.green)
                                .padding(.top, 0.5)
                                .padding(.bottom, 8.0)
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
                        Link("\(Image(systemName: "car.2")) ᴛᴇʟʀᴀᴀᴍ ᴛʀᴀғғɪᴄ (ʟᴀsᴛ ᴡʜᴏʟᴇ ʜᴏᴜʀ)",
                             destination: URL(string: "https://www.telraam.net/en/location/\(ProfileEditor().segmentID)")!)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8.0)
                        
                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.pedestrian ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 50, height: 50)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 8.0)
                                VStack{
                                    Text("🚶")
                                        .font(.headline)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.pedestrian ?? 0))))")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.bike ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 50, height: 50)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 8.0)
                                VStack{
                                    Text("🚲")
                                        .font(.headline)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.bike ?? 0))))")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.car ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 50, height: 50)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 8.0)
                                VStack{
                                    Text("🚗")
                                        .font(.headline)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.car ?? 0))))")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            ZStack{
                                ProgressView("", value: Float16(telraamViewModel.telraamData.properties?.lorry ?? 0), total: 50)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 50, height: 50)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 8.0)
                                VStack{
                                    Text("🚚")
                                        .font(.headline)
                                    Text("\(String(Int(round(telraamViewModel.telraamData.properties?.lorry ?? 0))))")
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
                
                
                if ProfileEditor().ClimateChangeStats == true
                {
                    VStack{
                        if ProgressIndicatorShown == true{
                            ProgressView()
                        }
                        Link("\(Image(systemName: "globe")) ᴄʟɪᴍᴀᴛᴇ ᴄʜᴀɴɢᴇ sᴛᴀᴛs",
                             destination: URL(string: "https://www.global-warming.org")!)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8.0)
                        
                        HStack{
                            ZStack{
                                ProgressView("", value: Float16(dailyAtmosphericCO2Data365Last), total: 450)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 6.0)
                                VStack{
                                    Text("⚫")
                                        .font(.subheadline)
                                    Text("\(dailyAtmosphericCO2Data365Last)")
                                        .font(.caption)
                                    Text("ᴘᴘᴍ ᴄᴏ₂")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            VStack{
                                Text("\(String(format: "%.2f", locale: Locale.current, cO2PPMLastYearOnYearDeltaPercentage))% Δ CO₂ Emissions Year on Year")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("( Short term reading, should be <0% )")
                                    .font(.caption)
                                    .padding(.bottom, 2.0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(String(format: "%.1f", locale: Locale.current, cO2PPMAnnualAverageSinceUNEPMilestoneDeltaPercentage))% Average CO₂ Emissions since 2019")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("( Should be <-7.6%  to limit to +1.5℃ )")
                                    .font(.caption)
                                    .padding(.bottom, 2.0)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            }
                        }
                        
                        Spacer()
                        
                        HStack{
                            ZStack{
                                ProgressView("", value: Float16(globalWarmingLastValue), total: 2)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 70, height: 70)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 6.0)
                                VStack{
                                    Text("🌡")
                                        .font(.subheadline)
                                    Text("\(globalWarmingLastValue)℃")
                                        .font(.caption)
                                    Text("\(globalWarmingLastTime)")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            VStack{
                                Text("Monthly mean surface temp. anomaly")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 2.0)
                                
                                Text("\(String(format: "%.1f", locale: Locale.current, globalWarmingLastYearOnYearDeltaPercentage))% Δ Year on Year")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("( Should be negative )")
                                    .font(.caption)
                                    .padding(.bottom, 2.0)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            }
                        }
                    }
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
        
        if ProfileEditor().ClimateChangeStats == true
        {
            DataLoaderDailyAtmosphericCO2().loadDailyAtmosphericCO2Data()
            DataLoaderGlobalWarming().loadGlobalWarmingData()
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
                
                if ProfileEditor().ClimateChangeStats == true
                {
                    if (dailyAtmosphericCO2Data.co2?.last?.cycle) != nil {
                        
                        dailyAtmosphericCO2Data365Last = String(dailyAtmosphericCO2Data.co2?.last?.trend ?? "0")
                        
                        let dailyAtmosphericCO2DataArraySize = dailyAtmosphericCO2Data.co2?.count ?? 0
                        
                        let dailyAtmosphericCO2DataArray365DaysAgo = dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-365]
                        let dailyAtmosphericCO2Data365DaysAgo = dailyAtmosphericCO2DataArray365DaysAgo?.trend ?? "0"
                        let cO2PPMLastAnnualDelta = ((dailyAtmosphericCO2Data.co2?.last?.trend ?? "0") as NSString).doubleValue - (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue
                        
                        let dailyAtmosphericCO2DataArray730DaysAgo = dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-730]
                        let dailyAtmosphericCO2Data730DaysAgo = dailyAtmosphericCO2DataArray730DaysAgo?.trend ?? "0"
                        let cO2PPMPrecedingAnnualDelta = (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue - (dailyAtmosphericCO2Data730DaysAgo as NSString).doubleValue
                        
                        cO2PPMLastYearOnYearDeltaPercentage = (cO2PPMLastAnnualDelta / (dailyAtmosphericCO2Data365DaysAgo as NSString).doubleValue) * 100
                        
                        let daysSinceUNEPMilestone = ((((Date.timeIntervalSinceReferenceDate - 599529600)/60)/60)/24)
                        let yearsSinceUNEPMilestone = (((((Date.timeIntervalSinceReferenceDate - 599529600)/60)/60)/24)/365)
                        
                        let dailyAtmosphericCO2DataArrayOnUNEPMilestone = ((dailyAtmosphericCO2Data.co2?[dailyAtmosphericCO2DataArraySize-Int(daysSinceUNEPMilestone)].trend ?? "0") as NSString).doubleValue
                        
                        cO2PPMAnnualAverageSinceUNEPMilestoneDeltaPercentage = (((((dailyAtmosphericCO2Data.co2?.last?.trend ?? "0") as NSString).doubleValue - dailyAtmosphericCO2DataArrayOnUNEPMilestone) / dailyAtmosphericCO2DataArrayOnUNEPMilestone) * 100) / yearsSinceUNEPMilestone
                        
                    }
                    
                    let globalWarmingArraySize = globalWarmingData.result?.count ?? 0
                    
                    let globalWarmingDataArray1MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-1]
                    let globalWarmingDataArray2MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-2]
                    let globalWarmingDataArray3MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-3]
                    let globalWarmingDataArray4MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-4]
                    let globalWarmingDataArray5MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-5]
                    let globalWarmingDataArray6MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-6]
                    let globalWarmingDataArray7MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-7]
                    let globalWarmingDataArray8MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-8]
                    let globalWarmingDataArray9MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-9]
                    let globalWarmingDataArray10MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-10]
                    let globalWarmingDataArray11MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-11]
                    let globalWarmingDataArray12MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-12]
                    let globalWarmingDataArray13MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-13]
                    let globalWarmingDataArray14MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-14]
                    let globalWarmingDataArray15MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-15]
                    let globalWarmingDataArray16MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-16]
                    let globalWarmingDataArray17MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-17]
                    let globalWarmingDataArray18MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-18]
                    let globalWarmingDataArray19MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-19]
                    let globalWarmingDataArray20MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-20]
                    let globalWarmingDataArray21MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-21]
                    let globalWarmingDataArray22MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-22]
                    let globalWarmingDataArray23MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-23]
                    let globalWarmingDataArray24MonthsAgo = globalWarmingData.result?[globalWarmingArraySize-24]
                    
                    let globalWarmingLast12MonthsAgoTotal = (((globalWarmingDataArray1MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray2MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray3MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray4MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray5MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray6MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray7MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray8MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray9MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray10MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray11MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray12MonthsAgo?.land ?? "0") as NSString).doubleValue)
                    let globalWarmingLast12MonthsAgoAverage = globalWarmingLast12MonthsAgoTotal / 12
                    
                    let globalWarming24MonthsAgo12MonthsTotal = (((globalWarmingDataArray13MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray14MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray15MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray16MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray17MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray18MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray19MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray20MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray21MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray22MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray23MonthsAgo?.land ?? "0") as NSString).doubleValue + ((globalWarmingDataArray24MonthsAgo?.land ?? "0") as NSString).doubleValue)
                    let  globalWarming24MonthsAgo12MonthsAverage = globalWarming24MonthsAgo12MonthsTotal / 12
                    
                    globalWarmingLastYearOnYearDeltaPercentage = ((globalWarmingLast12MonthsAgoAverage - globalWarming24MonthsAgo12MonthsAverage) / globalWarming24MonthsAgo12MonthsAverage) * 100
                    
                    globalWarmingLastValue = globalWarmingData.result?.last?.land ?? "◌"
                    globalWarmingLastTime = globalWarmingData.result?.last?.time ?? "◌"
                    
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
                    self.precipitationProbability = climaCellData.data?.timelines?[0].intervals?[1].values?.precipitationProbability ?? 0
                    
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
