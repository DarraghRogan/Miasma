//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import CoreLocation

public struct ContentViewSmartCitizen: View {
    
    // Heavly implementing combine per https://engineering.nodesagency.com/categories/ios/2020/03/16/Combine-networking-with-a-hint-of-swiftUI
    
    @ObservedObject var smartCitizenViewModel = SmartCitizenViewModel()
    
    @ObservedObject var telraamViewModel = TelraamViewModel()
    
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
    
    
    // Defining VARs for SmartCitizen
    @State var pM2_5Value: Double = 0
    @State var aQI_CalculatedDouble: Double = 0
    @State var aQI_CalculatedRounded: Double = 0
    @State var fahrenheitForDisplaySmartCitizen: String = "◌"
    //    @State var pm25historicalString1d: Double = 0
    @State var outputpm25historicalString1d: String = "◌"
    @State var displaypm25historicalString1d: String = "◌"
    @State var outputpm25historicalString1w: String = "◌"
    @State var displaypm25historicalString1w: String = "◌"
    //    @State var pm25historicalString1y: Double = 0
    @State var outputpm25historicalString1y: String = "◌"
    @State var displaypm25historicalString1y: String = "◌"
    
    
    
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
                    Link("\(smartCitizenViewModel.smartCitizenData.location?.city ?? "◌") ᴀɪʀ ǫᴜᴀʟɪᴛʏ",
                         destination: URL(string: "https://smartcitizen.me/kits/\(ProfileEditor().SensorID)" ?? "https://smartcitizen.me/kits/")!)
                    .font(.headline)
                    
                    HStack {
                        ProgressView("☁️ \(Int(aQI_CalculatedRounded)) ᴜs ᴇᴘᴀ ᴀǫɪ  / \(String(Int(smartCitizenViewModel.smartCitizenData.sensors?[8].value ?? 0))) µɢ/ᴍ³ ᴘᴍ₂.₅", value: aQI_CalculatedRounded, total: 500)
                            .progressViewStyle(aQIProgressBarStyle())
                            .padding(.top, 0.5)
                            .padding(.bottom, 7.0)
                    }
                    
                    HStack {
                        ZStack{
                            ProgressView("", value: Float16(smartCitizenViewModel.smartCitizenData.sensors?[10].value ?? 0)+17.78, total: 57)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 70, height: 70)
                                .contentShape(Rectangle())
                                .padding(.bottom, 4.0)
                            VStack{
                                Text("🌡")
                                    .font(.subheadline)
                                Text("\(String(Int(smartCitizenViewModel.smartCitizenData.sensors?[10].value ?? 0)))℃")
                                    .font(.caption)
                                Text("/ \(self.fahrenheitForDisplaySmartCitizen)℉")
                                    .font(.caption)
                            }
                        }
                        
                        Spacer()
                        
                        ZStack{
                            ProgressView("", value: Float16(smartCitizenViewModel.smartCitizenData.sensors?[9].value ?? 0), total: 100)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 70, height: 70)
                                .contentShape(Rectangle())
                                .padding(.bottom, 4.0)
                            VStack{
                                Text("💧")
                                    .font(.subheadline)
                                Text("\(String(Int(smartCitizenViewModel.smartCitizenData.sensors?[9].value ?? 0)))%")
                                    .font(.caption)
                                Text("ʀᴇʟ. ʜᴜᴍ.")
                                    .font(.caption)
                            }
                        }
                        
                        Spacer()
                        
                        ZStack{
                            ProgressView("", value: Float16(smartCitizenViewModel.smartCitizenData.sensors?[5].value ?? 98)-98, total: 5)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 70, height: 70)
                                .contentShape(Rectangle())
                                .padding(.bottom, 4.0)
                            VStack{
                                Text("🌬️")
                                    .font(.subheadline)
                                Text("\(String(smartCitizenViewModel.smartCitizenData.sensors?[5].value ?? 0))kPa")
                                    .font(.caption)
                                Text("ᴘʀᴇs.")
                                    .font(.caption)
                            }
                        }
                        
                        Spacer()
                        
                        VStack{
                            Text("Averages")
                                .font(.subheadline)
                            Text("1 Day: \(displaypm25historicalString1d)")
                                .font(.caption)
                            Text("1 Week: \(displaypm25historicalString1w)")
                                .font(.caption)
                            Text("1 Year: \(displaypm25historicalString1y)")
                                .font(.caption)
                            Text("µɢ/ᴍ³ ᴘᴍ₂.₅")
                                .font(.caption)
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
                                    Text("ꜰʀᴏᴍ \(windDirection_acronymn)")
                                        .font(.caption)
                                }
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
                                    Text("\(climaCellEPAAQI) ᴜs ᴀǫɪ ᴇᴘᴀ")
                                        .font(.caption)
                                    Text("ᴍᴀɪɴʟʏ \(climaCellEPAPrimaryPollutant)")
                                        .font(.caption)
                                }
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
                        //                            .padding(.top, 5.0)
                        .font(.headline)
                        
                        
                        HStack {
                            ProgressView("⚡️ \(Int(carbonIntensity))gCO₂eq/kWh ɢʀɪᴅ ᴄᴀʀʙᴏɴ ɪɴᴛᴇɴsɪᴛʏ", value: 100-(fossilFuelPercentage), total: 100)
                                .accentColor(.green)
                                .padding(.top, 0.5)
                                .padding(.bottom, 4.0)
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
                        .font(.headline)
                        
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
                                }
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
                
                Button("🔄", action: {
                    updateListEntry()
                } )
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            .onAppear() {
                self.updateListEntry()
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
        
        DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData1d(id: (ProfileEditor().SensorID) as? String ?? String())
        
        DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData1y(id: (ProfileEditor().SensorID) as? String ?? String())
        
        DataLoaderSmartCitizenHistorical().loadSmartCitizenHistoricalData1w(id: (ProfileEditor().SensorID) as? String ?? String())
        
        func generatesmartCitizen24HourAverage(pm25historicalString:String) -> String{
            
            let step1 = pm25historicalString.replacingOccurrences(of: "[^\\.\\d+]", with: "", options: [.regularExpression])
            
            let step2 = NumberFormatter().number(from: step1)?.doubleValue
            
            let step3:Int = Int(round(step2 ?? 0.0))
            
            switch (step3) {
                
            case _ where step3 >= 0 && step3 < 15:
                return String("\(step3) ✓")
                
            case _ where step3 >= 15 && step3 < 25:
                return String("\(step3) ④")
                
            case _ where step3 >= 25 && step3 < 37:
                return String("\(step3) ③")
                
            case _ where step3 >= 37 && step3 < 50:
                return String("\(step3) ②")
                
            case _ where step3 >= 50 && step3 < 75:
                return String("\(step3) ①")
                
            case _ where step3 >= 75:
                return String("\(step3) ⓪")
                
            default:
                return String("\(step3)")
                
            }
            
        }
        
        func generatesmartCitizenAnnualAverage(pm25historicalString:String) -> String{
            
            let step1 = pm25historicalString.replacingOccurrences(of: "[^\\.\\d+]", with: "", options: [.regularExpression])
            
            let step2 = NumberFormatter().number(from: step1)?.doubleValue
            
            let step3:Int = Int(round(step2 ?? 0.0))
            
            switch (step3) {
                
            case _ where step3 >= 0 && step3 < 5:
                return String("\(step3) ✓")
                
            case _ where step3 >= 5 && step3 < 10:
                return String("\(step3) ④")
                
            case _ where step3 >= 10 && step3 < 15:
                return String("\(step3) ③")
                
            case _ where step3 >= 15 && step3 < 25:
                return String("\(step3) ②")
                
            case _ where step3 >= 25 && step3 < 35:
                return String("\(step3) ①")
                
            case _ where step3 >= 35:
                return String("\(step3) ⓪")
                
            default:
                return String("\(step3)")
                
            }
            
        }
        
        //        smartCitizenViewModel.getSmartCitizen()
        //        smartCitizenViewModel.objectWillChange.send()
        
        //        telraamViewModel.getTelraam()
        //        telraamViewModel.objectWillChange.send()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.05) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                print("running +3s data loaders")
                
                ProgressIndicatorShown = true
                
                // Get Latitude & longitude to feed into other APIs
                self.locationCoordinate = CLLocationCoordinate2DMake(smartCitizenViewModel.smartCitizenData.location?.latitude ?? 0, smartCitizenViewModel.smartCitizenData.location?.longitude ?? 0)
                
                self.sensorLatitude = smartCitizenViewModel.smartCitizenData.location?.latitude ?? 0
                self.sensorLongitude = smartCitizenViewModel.smartCitizenData.location?.longitude ?? 0
                
                // show historical smartcitizen pm2.5 data
                if let pm25historicalString1d = smartCitizenHistoricalData1d.readings?[1][1]
                {
                    outputpm25historicalString1d = String("\(pm25historicalString1d)")
                    displaypm25historicalString1d = generatesmartCitizen24HourAverage(pm25historicalString:outputpm25historicalString1d)
                }
                
                if let pm25historicalString1w = smartCitizenHistoricalData1w.readings?[1][1]
                {
                    outputpm25historicalString1w = String("\(pm25historicalString1w)")
                    displaypm25historicalString1w = generatesmartCitizenAnnualAverage(pm25historicalString:outputpm25historicalString1w)
                }
                
                if let pm25historicalString1y = smartCitizenHistoricalData1y.readings?[0][1]
                {
                    outputpm25historicalString1y = String("\(pm25historicalString1y)")
                    displaypm25historicalString1y = generatesmartCitizenAnnualAverage(pm25historicalString:outputpm25historicalString1y)
                }
                
                
                
                //                print(generatesmartCitizen24HourAverage(pm25historicalString:outputpm25historicalString1d))
                //                print(generatesmartCitizenAnnualAverage(pm25historicalString:outputpm25historicalString1y))
                
                // Calculate AQI & create images
                self.pM2_5Value = round((smartCitizenViewModel.smartCitizenData.sensors?[8].value ?? 0.0))
                switch (pM2_5Value) {
                case _ where pM2_5Value >= 0 && pM2_5Value < 12:
                    
                    self.aQI_CalculatedDouble = ((50-0)/(12-0))*((pM2_5Value)-0)+0
                    self.aQI_CalculatedRounded = Double(Int(round(self.aQI_CalculatedDouble)))
                    AppDelegate().defaults.set("🟢", forKey: "PreviousStateForNotification")
                    
                case _ where pM2_5Value >= 12 && pM2_5Value < 35.5:
                    self.aQI_CalculatedDouble = ((100-51)/(35.4-12.1))*((pM2_5Value)-12.1)+51
                    self.aQI_CalculatedRounded = Double(Int(round(self.aQI_CalculatedDouble)))
                    AppDelegate().defaults.set("🟡", forKey: "PreviousStateForNotification")
                    
                case _ where pM2_5Value >= 35.5 && pM2_5Value < 55.5:
                    self.aQI_CalculatedDouble = ((150-101)/(55.4-35.5))*((pM2_5Value)-35.5)+101
                    self.aQI_CalculatedRounded = Double(Int(round(self.aQI_CalculatedDouble)))
                    AppDelegate().defaults.set("🟠", forKey: "PreviousStateForNotification")
                    
                case _ where pM2_5Value >= 55.5 && pM2_5Value < 150.5:
                    aQI_CalculatedDouble = ((200-151)/(150.4-55.5))*((pM2_5Value)-55.5)+151
                    self.aQI_CalculatedRounded = Double(Int(round(self.aQI_CalculatedDouble)))
                    AppDelegate().defaults.set("🔴", forKey: "PreviousStateForNotification")
                    
                case _ where pM2_5Value >= 150.5 && pM2_5Value < 250.5:
                    self.aQI_CalculatedDouble = ((300-201)/(250.4-150.5))*((pM2_5Value)-150.5)+201
                    self.aQI_CalculatedRounded = Double(Int(round(self.aQI_CalculatedDouble)))
                    AppDelegate().defaults.set("🟣", forKey: "PreviousStateForNotification")
                    
                case _ where pM2_5Value >= 250.5 && pM2_5Value < 500.5:
                    self.aQI_CalculatedDouble = ((500-301)/(500.4-250.5))*((pM2_5Value)-250.5)+301
                    self.aQI_CalculatedRounded = Double(Int(round(self.aQI_CalculatedDouble)))
                    AppDelegate().defaults.set("🟤", forKey: "PreviousStateForNotification")
                    
                case _ where pM2_5Value >= 500.5:
                    self.aQI_CalculatedRounded = 500
                    AppDelegate().defaults.set("🟤", forKey: "PreviousStateForNotification")
                    
                default:
                    self.aQI_CalculatedRounded = 0
                    AppDelegate().defaults.set("⚪", forKey: "PreviousStateForNotification")
                }
                
                self.fahrenheitForDisplaySmartCitizen = calculateFahrenheit(celcius: smartCitizenViewModel.smartCitizenData.sensors?[10].value ?? 0)
                
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    DataLoaderCO2().loadCO2Data(lat: String(sensorLatitude), lon: String(sensorLongitude))
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
                
                
                // a little protection for when over API calls to ClimaCell, a la : https://stackoverflow.com/questions/25976909/swift-array-check-if-an-index-exists
                var isIndexValid: Bool = false
                if 2 < climaCellData.data?.timelines?[0].intervals?.count ?? 0 {
                    isIndexValid = true
                } else {
                    
                }
                
                if ProfileEditor().OneHourForecastDataWanted == true && isIndexValid == true
                {
                    
                    self.climaCellWindDirection = climaCellData.data?.timelines?[0].intervals?[1].values?.windDirection ?? 0
                    self.climaCellFeelsLike = climaCellData.data?.timelines?[0].intervals?[1].values?.temperatureApparent ?? 0
                    self.climaCellWindSpeed = climaCellData.data?.timelines?[0].intervals?[1].values?.windSpeed ?? 0
                    self.climaCellEPAAQI = climaCellData.data?.timelines?[0].intervals?[1].values?.epaIndex ?? 0
                    //                    self.climaCellEPAPrimaryPollutant = ClimaCellPrimaryPollutant
                    self.climaCellPollenTree = Int(climaCellData.data?.timelines?[0].intervals?[1].values?.treeIndex ?? 0)
                    self.climaCellPollenGrass = Int(climaCellData.data?.timelines?[0].intervals?[1].values?.grassIndex ?? 0)
                    self.climaCellPollenWeed = Int(climaCellData.data?.timelines?[0].intervals?[1].values?.weedIndex ?? 0)
                    
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
    
    
    struct ContentViewWAQI_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
                    .environment(\.sizeCategory, .small)
            }
        }
    }
    
}

