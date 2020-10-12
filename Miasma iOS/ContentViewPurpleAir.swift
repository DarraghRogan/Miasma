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
    @State var fahrenheitForDisplay: String = "0"
    @State var celciusForCalculation: Double = 0
    
    // Defining VARs for PurpleAir
    @State var pM2_5Value: Double = 0
    @State var pM2_5ColourButton: String = "[______]"
    @State var aQI_CalculatedDouble: Double = 0
    @State var aQI_CalculatedRounded: Int = 0
    @State var celciusForDisplay: String = "◌"
    @State var fahrenheitForCalculation: Double = 0
    @State var pressure_visual: String = "[___/______/____]"
    
    // Defining VARs for CO2 Signal
    @State var fossilFuelPercentage_visual: String = "[__________]"
    
    // Defining VARs for ClimaCell
    @State var windDirection_acronymn: String = "___"
    
    public var body: some View {
        
        MapView(coordinate: locationCoordinate)
            .edgesIgnoringSafeArea(.top)
            .frame(height: 100)
        
        VStack {
            
            List
            {
                
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
                        Text("US EPA AQI PM₂.₅ is \(aQI_CalculatedRounded)   \(pM2_5ColourButton)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                    }
                    
                    HStack {
                        Text("🌡")
                        Spacer()
                        Text("\(self.celciusForDisplay)℃ / \(String((purpleAirViewModel.purpleAirdata.temperatureA ?? 0)-8))℉")
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
                        Text("\(String(purpleAirViewModel.purpleAirdata.pressureA ?? 0)) millibar  \(pressure_visual)")
                            .font(.footnote)
                            .padding(.top, 5.0)
                    }
                    
                    HStack {
                        Text("📅")
                        Spacer()
                        Text("Reading \(String(Int((NSDate().timeIntervalSince1970))-(purpleAirViewModel.purpleAirdata.lastSeen ?? 0))) seconds old at Miasma refresh time")
                            .font(.footnote)
                            .padding(.top, 5.0)
                    }
                    
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
                            Text("\(String(format: "%.1f", locale: Locale.current,(100-fossilFuelPercentage)))% Low CO₂ \(self.fossilFuelPercentage_visual)")
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
                             destination: URL(string: "itms-apps://itunes.apple.com/app/id1443325509")!)
                            .padding(.top, 8.0)
                            .font(.headline)
                        
                        HStack {
                            Text("🌦")
                            Spacer()
                            Text("Will be \(climaCellWeatherCode), feel like \(String(format: "%.1f", locale: Locale.current, climaCellFeelsLike))℃ / \(fahrenheitForDisplay)℉, with wind from \(windDirection_acronymn) @ \(String(format: "%.1f", locale: Locale.current, climaCellWindSpeed))m/s / \(Int(climaCellWindSpeed*3.6))km/h / \(Int(climaCellWindSpeed*2.23694))mph")
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
                // ranges for pressure values from https://www.thoughtco.com/how-to-read-a-barometer-3444043
                switch (pressureValue) {
                case _ where pressureValue < 1009.144:
                    self.pressure_visual = "[Low/______/____]"
                case _ where pressureValue > 1009.144 && pressureValue < 1022.689:
                    self.pressure_visual = "[___/Normal/____]"
                case _ where pressureValue > 1022.689:
                    self.pressure_visual = "[___/______/High]"
                default:
                    self.pressure_visual = ""
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
                    switch (fossilFuelPercentage) {
                    case _ where fossilFuelPercentage > 0 && fossilFuelPercentage < 5:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️♻️]"
                    case _ where fossilFuelPercentage > 5 && fossilFuelPercentage < 15:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️♻️🦖]"
                    case _ where fossilFuelPercentage > 15 && fossilFuelPercentage < 25:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️♻️🦖🦖]"
                    case _ where fossilFuelPercentage > 25 && fossilFuelPercentage < 35:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️♻️🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 35 && fossilFuelPercentage < 45:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️♻️🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 45 && fossilFuelPercentage < 55:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️♻️🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 55 && fossilFuelPercentage < 65:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️♻️🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 65 && fossilFuelPercentage < 75:
                        self.fossilFuelPercentage_visual = "[♻️♻️♻️🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 75 && fossilFuelPercentage < 85:
                        self.fossilFuelPercentage_visual = "[♻️♻️🦖🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 85 && fossilFuelPercentage < 95:
                        self.fossilFuelPercentage_visual = "[♻️🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    case _ where fossilFuelPercentage > 95:
                        self.fossilFuelPercentage_visual = "[🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖]"
                    default:
                        fossilFuelPercentage_visual = "[          ]"
                    }
                    
                }
                
                if ProfileEditor().AircraftDataWanted == true
                {
                    self.openSkyAircraftInBox = openSkyData.states?.count ?? 0
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
