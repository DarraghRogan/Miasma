/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 An editable profile view.
 */

import SwiftUI

struct ProfileEditor: View {
    
    @AppStorage("AirQualityDataSource") var AirQualityDataSource = "WAQI/AQICN"
    
    @AppStorage("SensorID") var SensorID = "here"
    
    @AppStorage("ElectricalConsumptionDataWanted") var ElectricalConsumptionDataWanted = false
    
    //    @AppStorage("AircraftDataWanted") var AircraftDataWanted = true
    
    @AppStorage("OneHourForecastDataWanted") var OneHourForecastDataWanted = false
    
    @AppStorage("NotificationsWanted") var NotificationsWanted = false
    
    @AppStorage("TelraamDataWanted") var TelraamDataWanted = false
    @AppStorage("SegmentID") var segmentID = ""
    
    var body: some View {
        List {
            Text("Miasma Preferences")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title)
            VStack{
                Text("Please choose air quality data source, and enter desired sensor ID.")
                    .font(.caption)
                Text("For WAQI/AQICN, search on AQICN.org for city name (one word, no spaces), or set to 'here'")
                    .font(.caption)
                Text("For PurpleAir & SmartCitizen, enter 4 to 6 digit sensor ID from the webpages' Map view URL")
                    .font(.caption)
                HStack{
                    Menu("Air Quality Data Source") /*@START_MENU_TOKEN@*/{
                        Button("PurpleAir", action: {AppDelegate().defaults.set("PurpleAir", forKey: "AirQualityDataSource")})
                        Button("WAQI/AQICN", action: {AppDelegate().defaults.set("WAQI/AQICN", forKey: "AirQualityDataSource")})
                        Button("Smart Citizen", action: {AppDelegate().defaults.set("SmartCitizen", forKey: "AirQualityDataSource")})
                    }/*@END_MENU_TOKEN@*/
                    
                    Divider()
                    Text("\(AirQualityDataSource)")
                }
                HStack {
                    Text("Sensor ID")
                    Divider()
                    TextField("Sensor ID", text: $SensorID)
                        .disableAutocorrection(true)
                        .autocapitalization(UITextAutocapitalizationType.none)
                }

            }
            Toggle(isOn: $ElectricalConsumptionDataWanted) {
                Text("Enable Electricty Consumpt. data")
            }
            //            Toggle(isOn: $AircraftDataWanted) {
            //                Text("Enable Aircraft Overhead data")
            //            }
            .disabled(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            Toggle(isOn: $OneHourForecastDataWanted) {
                Text("Enable 1 Hour Forecast")
            }
            //            Toggle(isOn: $NotificationsWanted) {
            //                Text("Enable Notifications")
            //            }
            VStack{
                Text("Please enter 10 digit ID from Telraam webpage")
                    .font(.caption)
                Toggle(isOn: $TelraamDataWanted) {
                    Text("Enable Telraam Traffic Data")
                }
                HStack {
                    Text("Segment ID")
                    Divider()
                    TextField("Segment ID", text: $segmentID)
                        .disableAutocorrection(true)
                        .autocapitalization(UITextAutocapitalizationType.none)
                }
            }
            .padding(.top)
            
            
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor()
    }
}
