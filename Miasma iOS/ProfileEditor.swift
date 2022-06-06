/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 An editable profile view.
 */

import SwiftUI
import Combine

struct ProfileEditor: View {
    
    @AppStorage("AirQualityDataSource") var AirQualityDataSource = "WAQI/AQICN"
    
    @AppStorage("SensorID") var SensorID = "here"
    
    @AppStorage("ElectricalConsumptionDataWanted") var ElectricalConsumptionDataWanted = false
    
    @AppStorage("ShowWelcomeText") var ShowWelcomeText = true
    
    @AppStorage("OneHourForecastDataWanted") var OneHourForecastDataWanted = false
    
    @AppStorage("AirQualityLocalToDevice") var AirQualityLocalToDevice = true
    
    @AppStorage("NotificationsWanted") var NotificationsWanted = false
    
    @AppStorage("TelraamDataWanted") var TelraamDataWanted = false
    
    @AppStorage("SegmentID") var segmentID =  "9000002573"
    
    var body: some View {
        List {
            Text("Miasma Preferences")
                .fontWeight(.bold)
                .font(.headline)
            VStack{
                Text("\(Image(systemName: "house")) Selected Air Quality Data")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 1.5)
                Text("Please choose air quality data source")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    Menu("Data Provider") /*@START_MENU_TOKEN@*/{
                        Button("WAQI/AQICN", action: {AppDelegate().defaults.set("WAQI/AQICN", forKey: "AirQualityDataSource")})
                        Button("PurpleAir", action: {AppDelegate().defaults.set("PurpleAir", forKey: "AirQualityDataSource")})
                        Button("Smart Citizen", action: {AppDelegate().defaults.set("SmartCitizen", forKey: "AirQualityDataSource")})
                    }/*@END_MENU_TOKEN@*/
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    Text("\(AirQualityDataSource)")
                }
                .font(.subheadline)
                .padding(.bottom, 1.0)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Manually enter Sensor ID from provider webpage")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
//                HStack{
//                    Link("WAQI/AQICN", destination: URL(string: "https://aqicn.org/here/")!)
//                        .font(.subheadline)
//                    Spacer()
//                    Link("PurpleAir", destination: URL(string: "https://map.purpleair.com/")!)
//                        .font(.subheadline)
//                    Spacer()
//                    Link("SmartCitizen", destination: URL(string: "https://smartcitizen.me/kits/")!)
//                        .font(.subheadline)
//                }
//                HStack{
//                    Link("For WAQI/AQICN, search on AQICN.org for city name (one word, no spaces).", destination: URL(string: "https://aqicn.org/here/")!)
//                        .font(.caption)
//                        .multilineTextAlignment(.leading)
//                    Spacer()
//                    Text("\(Image(systemName: "link.circle"))")
//                        .font(.largeTitle)
//                }
//                HStack{
//                    Link("For PurpleAir, enter 4 to 6 digit sensor ID from the webpages' URL", destination: URL(string: "https://map.purpleair.com/")!)
//                        .font(.caption)
//                        .multilineTextAlignment(.leading)
//                    Spacer()
//                    Text("\(Image(systemName: "link.circle"))")
//                        .font(.largeTitle)
//                }
//                HStack{
//                    Link("For SmartCitizen, enter 4 to 6 digit sensor ID from the webpages' URL", destination: URL(string: "https://smartcitizen.me/kits/")!)
//                        .font(.caption)
//                        .multilineTextAlignment(.leading)
//                    Spacer()
//                    Text("\(Image(systemName: "link.circle"))")
//                        .font(.largeTitle)
//                }
                
                HStack {
                    Text("Sensor ID:")
                    Divider()
                    Spacer()
                    TextField("Sensor ID", text: $SensorID)
                        .disableAutocorrection(true)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .keyboardType(.asciiCapable)
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            Toggle(isOn: $AirQualityLocalToDevice) {
                Text("\(Image(systemName: "location.north")) Show Air Quality local to device")
                    .font(.subheadline)
            }
            Toggle(isOn: $ElectricalConsumptionDataWanted) {
                Text("\(Image(systemName: "bolt")) Electricty Consumption data")
                    .font(.subheadline)
            }
            
            //            .disabled(false)
            
            Toggle(isOn: $OneHourForecastDataWanted) {
                Text("\(Image(systemName: "binoculars")) Show 1 Hour Forecast")
                    .font(.subheadline)
            }
            
            VStack{
                Text("\(Image(systemName: "car.2")) Telraam Traffic Data")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 1.5)
                Text("Please enter 10 digit ID from Telraam webpage")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("Segment ID:")
                    Divider()
                    Spacer()
                    TextField("Segment ID", text: $segmentID)
                        .disableAutocorrection(true)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .keyboardType(.numberPad)
                        .onReceive(Just(segmentID)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.segmentID = filtered
                            }
                    }
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .trailing)
                Toggle(isOn: $TelraamDataWanted) {
                    Text("Enable Telraam Traffic Data")
                        .font(.subheadline)
                }
            }
            Toggle(isOn: $ShowWelcomeText) {
                Text("\(Image(systemName: "hand.wave")) Show Miasma welcome text")
                    .font(.subheadline)
            }
            //            .padding(.top)
            

        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor()
    }
}
