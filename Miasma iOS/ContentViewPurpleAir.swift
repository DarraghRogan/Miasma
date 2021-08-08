//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import CoreLocation

public struct ContentViewPurpleAir: View {
    
    // Heavly implementing combine per https://engineering.nodesagency.com/categories/ios/2020/03/16/Combine-networking-with-a-hint-of-swiftUI
    
    @ObservedObject var purpleAirViewModel = PurpleAirViewModel()
    
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
    @State var fahrenheitForDisplay: String = "0"
    @State var celciusForCalculation: Double = 0
    
    // Defining VARs for PurpleAir
    @State var pM2_5Value: Double = 0
    @State var pM2_5ColourButton: String = "[______]"
    @State var aQI_CalculatedDouble: Double = 0
    @State var aQI_CalculatedRounded: Double = 0
    @State var celciusForDisplay: String = "◌"
    @State var fahrenheitForCalculation: Double = 0
    @State var pressure_visual: String = "[___/______/____]"
    
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
            
            List{
                VStack{
                    if ProgressIndicatorShown == true{
                        ProgressView()
                    }
                    Link("\(purpleAirViewModel.purpleAirdata.name ?? "◌") ᴀɪʀ ǫᴜᴀʟɪᴛʏ",
                         destination: URL(string: "https://www.purpleair.com/map?opt=1/mAQI/a0/cC0&select=\(ProfileEditor().SensorID)")!)
                        .font(.headline)
                        .padding(.top, 5.0)
                    HStack {
                        ProgressView("☁️ \(Int(aQI_CalculatedRounded)) ᴜs ᴇᴘᴀ ᴀǫɪ ᴘᴍ₂.₅", value: aQI_CalculatedRounded, total: 500)
                            .progressViewStyle(aQIProgressBarStyle())
                            .padding(.top, 0.5)
                            .padding(.bottom, 7.0)
                            .onAppear() {
                                self.updateListEntry()
                            }

                    }
                    
                    HStack {
                        ZStack{
                            ProgressView("🌡 \(self.celciusForDisplay)℃ / \(String((purpleAirViewModel.purpleAirdata.temperatureA ?? 0)-8))℉", value: ((Float16(purpleAirViewModel.purpleAirdata.temperatureA ?? 0)-8)), total: 100)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                                .padding(.bottom, 4.0)
                            VStack{
                                Text("🌡")
                                    .font(.title)
                                Text("\(self.celciusForDisplay)℃ ")
                                Text("/ \(String((purpleAirViewModel.purpleAirdata.temperatureA ?? 0)-8))℉")
                            }
                        }
                        .onAppear() {
                            self.updateListEntry()
                        }
                        
                        Spacer()
                        ZStack{
                            ProgressView("💧 \((purpleAirViewModel.purpleAirdata.humidityA ?? 0)+4)% ʀᴇʟ. ʜᴜᴍ.", value: Float16(purpleAirViewModel.purpleAirdata.humidityA ?? 0)+4, total: 100)
                                .padding(.bottom, 4.0)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                            VStack{
                                Text("💧")
                                    .font(.title)
                                Text("\((purpleAirViewModel.purpleAirdata.humidityA ?? 0)+4)%")
                                Text("ʀᴇʟ. ʜᴜᴍ.")
                            }
                        }
                        .onAppear() {
                            self.updateListEntry()
                        }
                        Spacer()
                        ZStack{
                            ProgressView("🌬️ \(String(purpleAirViewModel.purpleAirdata.pressureA ?? 0))millibar ᴀᴛᴍᴏsᴘʜᴇʀɪᴄ ᴘʀᴇssᴜʀᴇ", value: ((purpleAirViewModel.purpleAirdata.pressureA ?? 980)-980), total: 50)
                                .padding(.bottom, 4.0)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                            VStack{
                                Text("🌬️")
                                    .font(.title)
                                Text("\(String(purpleAirViewModel.purpleAirdata.pressureA ?? 0))mb")
                                Text("ᴘʀᴇs.")
                            }
                        }
                        .onAppear() {
                            self.updateListEntry()
                        }
                        
                        
                    }
                    
                    
                    HStack {
                        Spacer()
                        Text("\(String(Int((NSDate().timeIntervalSince1970))-(purpleAirViewModel.purpleAirdata.lastSeen ?? 0))) seconds old; User Selected Station (PurpleAir) ⇀")
                            .font(.footnote)
                            .padding(.bottom, 10.0)
                            .onAppear() {
                                self.updateListEntry()
                            }
                    }
                    
                }
                .ignoresSafeArea()
                
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
                        Link("1 ʜᴏᴜʀ ꜰᴏʀᴇᴄᴀsᴛ: \(climaCellWeatherCode)",
                             destination: URL(string: "https://www.tomorrow.io/weather/")!)
                            .padding(.top, 8.0)
                            .font(.headline)

                        HStack {
                            ZStack{
                                ProgressView("", value: Float16(fahrenheitForDisplay), total: 100)
                                    .progressViewStyle(GaugeProgressStyle())
                                    .frame(width: 100, height: 100)
                                    .contentShape(Rectangle())
                                    .padding(.bottom, 4.0)
                                VStack{
                                    Text("🌡")
                                        .font(.title)
                                    Text("\(String(format: "%.1f", locale: Locale.current, climaCellFeelsLike))℃")
                                    Text("/ \(fahrenheitForDisplay)℉")
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
                

                Button("🔄", action: {
                    updateListEntry()
                } )
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                
            }
        }
        
    }
    
    
    
    public func updateListEntry() {
        
        ProgressIndicatorShown = true
        
        purpleAirViewModel.getPurpleAir()
        purpleAirViewModel.objectWillChange.send()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.05) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                print("running +3s data loaders")
                
                ProgressIndicatorShown = true
                
                
                // Get Latitude & longitude to feed into other APIs
                self.locationCoordinate = CLLocationCoordinate2DMake(purpleAirViewModel.purpleAirdata.latitude ?? 0, purpleAirViewModel.purpleAirdata.longitude ?? 0)
                
                self.sensorLatitude = purpleAirViewModel.purpleAirdata.latitude ?? 0
                self.sensorLongitude = purpleAirViewModel.purpleAirdata.longitude ?? 0
                
                self.locationCoordinate = CLLocationCoordinate2DMake(purpleAirViewModel.purpleAirdata.latitude ?? 0, purpleAirViewModel.purpleAirdata.longitude ?? 0)
                
                self.sensorLatitude = purpleAirViewModel.purpleAirdata.latitude ?? 0
                self.sensorLongitude = purpleAirViewModel.purpleAirdata.longitude ?? 0
                
                // Calculate AQI & create images
                self.pM2_5Value = round(((purpleAirViewModel.purpleAirdata.pm25_A ?? 0) + (purpleAirViewModel.purpleAirdata.pm25_B ?? 0))/2)
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
                
                
                // Calculate Celcius from Farenheit for PA
                // note adjusting by 8F per Reddit post
                fahrenheitForCalculation = Double((purpleAirViewModel.purpleAirdata.temperatureA ?? 0)-8)
                func calculateCelsius(fahrenheit: Double) -> String {
                    var celsius: Double
                    celsius = (fahrenheit - 32) * 5 / 9
                    let celciusRoundedString = String(format: "%.1f", locale: Locale.current, celsius)
                    return celciusRoundedString
                }
                self.celciusForDisplay = calculateCelsius(fahrenheit: fahrenheitForCalculation)
                
                // Determine pressure visual
                let pressureValue = Double(purpleAirViewModel.purpleAirdata.pressureA ?? 0)
                
                
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.05) { // sort of URL session task
            DispatchQueue.main.async { // you need to update it in main thread!
                
                print("updating +7s list entries")
                
                ProgressIndicatorShown = false
                
                if ProfileEditor().ElectricalConsumptionDataWanted == true
                {
                    self.cO2Country = cO2Data.countryCode ?? ""
                    self.carbonIntensity = cO2Data.data?.carbonIntensity ?? 0
                    
                    self.fossilFuelPercentage = cO2Data.data?.fossilFuelPercentage ?? 0
                    
                }
                
                
                
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
                    celciusForCalculation = climaCellData[0].feelsLike?.value ?? 0
                    func calculateFahrenheit(celcius: Double) -> String {
                        var fahrenheit: Double
                        fahrenheit = (celcius  * 9 / 5) + 32
                        let fahrenheitRoundedString = String(format: "%.1f", locale: Locale.current, fahrenheit)
                        return fahrenheitRoundedString
                    }
                    self.fahrenheitForDisplay = calculateFahrenheit(celcius: celciusForCalculation)
                }
                
            }
        }
    }
    
    struct ContentViewPurpleAir_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
                    .environment(\.sizeCategory, .small)
            }
        }
    }
    
}
