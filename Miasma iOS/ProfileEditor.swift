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
    
    @AppStorage("AircraftDataWanted") var AircraftDataWanted = false
    
    @AppStorage("OneHourForecastDataWanted") var OneHourForecastDataWanted = false
    
    @AppStorage("NotificationsWanted") var NotificationsWanted = false


    var body: some View {
        List {
            HStack {
                Menu("Air Quality Data Source") /*@START_MENU_TOKEN@*/{
                    Button("PurpleAir", action: {AppDelegate().defaults.set("PurpleAir", forKey: "AirQualityDataSource")})
                    Button("WAQI/AQICN", action: {AppDelegate().defaults.set("WAQI/AQICN", forKey: "AirQualityDataSource")})
//                    Button("EU Smart Citizen", action: {AppDelegate().defaults.set("EU Smart Citizen", forKey: "AirQualityDataSource")})
                }/*@END_MENU_TOKEN@*/
                Divider()
                Text("\(AirQualityDataSource)")
            }
            HStack {
                Text("Sensor ID")
                Divider()
                TextField("Sensor ID", text: $SensorID)
                    .disableAutocorrection(true)
            }
            Toggle(isOn: $ElectricalConsumptionDataWanted) {
                Text("Enable Electricty Consumption data")
            }
            Toggle(isOn: $AircraftDataWanted) {
                Text("Enable Aircraft Overhead data")
            }
            Toggle(isOn: $OneHourForecastDataWanted) {
                Text("Enable 1 Hour Forecast")
            }
            Toggle(isOn: $NotificationsWanted) {
                Text("Enable Notifications")
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
