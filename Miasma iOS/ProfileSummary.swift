/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view that summarizes a profile.
 */

import SwiftUI
import AppTrackingTransparency

let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject

struct ProfileSummary: View {

    var body: some View {
        List {
            Text("Miasma Preferences")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title)
            HStack{
                Text("Air Quality data:")
                Spacer()
                Text("\(ProfileEditor().AirQualityDataSource)")
                Text("\(ProfileEditor().SensorID)")
            }
            
            HStack{
                Text("Electricty Consumption data:")
                Spacer()
                Text("\((ProfileEditor().ElectricalConsumptionDataWanted) ? "On": "Off" )")
            }
                        HStack{
                            Text("Also show Air Quality local to device 📲:")
                            Spacer()
                            Text("\((ProfileEditor().AirQualityLocalToDevice) ? "On": "Off" )")
                        }
            HStack{
                Text("1 Hour Forecast:")
                Spacer()
                Text("\((ProfileEditor().OneHourForecastDataWanted) ? "On": "Off" )")
            }
            HStack{
                Text("Telraam Traffic Data:")
                Spacer()
                Text("\((ProfileEditor().TelraamDataWanted) ? "On": "Off" )")
            }
                        HStack{
                            Text("Miasma welcome text:")
                            Spacer()
                            Text("\((ProfileEditor().ShowWelcomeText) ? "On": "Off" )")
                        }
            HStack{
                Text("Review / Feedback for Miasma")
                Spacer()
                Link("⇀", destination: URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
            }
            HStack{
                Text("About Miasma")
                Spacer()
                Link("⇀", destination: URL(string: "https://miasma.app")!)
            }
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
