/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view that summarizes a profile.
 */

import SwiftUI

let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject


struct ProfileSummary: View {
    
    var body: some View {
        List {
            Text("Miasma")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title)
            Button("Refresh \(ProfileEditor().AirQualityDataSource) Station: \(ProfileEditor().SensorID)", action: {
                AppDelegate().updateDataSources()
                ContentView().updateListEntry()
            })

            Text("Electricty Consumption data: \((ProfileEditor().ElectricalConsumptionDataWanted) ? "On": "Off" )")
            Text("Aircraft Overhead data: \((ProfileEditor().AircraftDataWanted) ? "On": "Off" )")
            Text("1 Hour Forecast: \((ProfileEditor().OneHourForecastDataWanted) ? "On": "Off" )")
            Text("Notifications: \((ProfileEditor().NotificationsWanted) ? "On": "Off" )")
            Link("Review / Suggestions for Miasma", destination: URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
            Link("About Miasma", destination: URL(string: "https://miasma.app")!)
            HStack{
            Text("Version:")
                Spacer()
                Text("\((nsObject.self ?? 1.00 as AnyObject) as! String)")
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary()
    }
}
