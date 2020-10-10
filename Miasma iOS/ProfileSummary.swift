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
                //                PurpleAirViewModel().getPurpleAir()
                //                WAQIViewModel().getWAQI()
                // Call the publisher
                if ProfileEditor().AirQualityDataSource == "WAQI/AQICN"{
                    ContentView().wAQIViewModel.objectWillChange.send()
                }
                
                if ProfileEditor().AirQualityDataSource == "PurpleAir"{
                    ContentView().purpleAirViewModel.objectWillChange.send()
                }
                ContentView().updateListEntry()
            })
            HStack{
                Text("Electricty Consumption data:")
                Spacer()
                Text("\((ProfileEditor().ElectricalConsumptionDataWanted) ? "On": "Off" )")
            }
            HStack{
                Text("Aircraft Overhead data:")
                Spacer()
                Text("\((ProfileEditor().AircraftDataWanted) ? "On": "Off" )")
            }
            HStack{
                Text("1 Hour Forecast:")
                Spacer()
                Text("\((ProfileEditor().OneHourForecastDataWanted) ? "On": "Off" )")
            }
            //            HStack{
            //                Text("Notifications:")
            //                Spacer()
            //                Text("\((ProfileEditor().NotificationsWanted) ? "On": "Off" )")
            //            }
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
