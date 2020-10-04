/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 An editable profile view.
 */

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    
    
    
    var body: some View {
        List {
            HStack {
                Menu("Air Quality Data Source") /*@START_MENU_TOKEN@*/{
                    Button("PurpleAir", action: {AppDelegate().defaults.set("PurpleAir", forKey: "AirQualityDataSource")})
                    Button("WAQI/AQICN", action: {AppDelegate().defaults.set("WAQI/AQICN", forKey: "AirQualityDataSource")})
                    Button("EU Smart Citizen", action: {AppDelegate().defaults.set("EU Smart Citizen", forKey: "AirQualityDataSource")})
                }/*@END_MENU_TOKEN@*/
                Divider()
                Text("\(AppDelegate().defaults.object(forKey:"AirQualityDataSource") as? String ?? String())")
            }
            HStack {
                Text("Sensor ID")
                Divider()
                TextField("Sensor ID", text: $profile.sensorID)
            }
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Electricty Consumption data")
            }
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Aircraft Overhead data")
            }
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable 1 Hour Forecast")
            }
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications")
            }
            
            .padding(.top)
            
            
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
