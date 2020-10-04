/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view that summarizes a profile.
 */

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile
    
    var body: some View {
        List {
            Text("Miasma")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title)
            Button("Refresh", action: {
                print("refresh")
            })

            HStack{
                Text("\(AppDelegate().defaults.object(forKey:"AirQualityDataSource") as? String ?? String())")
                Spacer()
                Text(AppDelegate().defaults.object(forKey:"AirQualityStationID") as? String ?? String())
            }
            Text("Electricty Consumption data: \((AppDelegate().defaults.object(forKey:"ElectricalConsumptionDataWanted") != nil) ? "On": "Off" )")
            Text("Aircraft Overhead data: \((AppDelegate().defaults.object(forKey:"AircraftDataWanted") != nil) ? "On": "Off" )")
            Text("1 Hour Forecast: \((AppDelegate().defaults.object(forKey:"1HourForecastDataWanted") != nil) ? "On": "Off" )")
            Text("Notifications: \((AppDelegate().defaults.object(forKey:"NotificationsWanted") != nil) ? "On": "Off" )")
            Link("Review / Suggestions for Miasma", destination: URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
            Link("About Miasma", destination: URL(string: "https://miasma.app")!)
            HStack{
            Text("Version:")
                Spacer()
                Text(" \(self.profile.prefersNotifications ? "On": "Off" )")
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}
