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
                .font(.headline)
            
            HStack{
                Text("\(Image(systemName: "house")) Selected Air Quality data:")
                Spacer()
                Text("\(ProfileEditor().AirQualityDataSource)")
                    .font(.caption2)
            }
            .font(.subheadline)
            
            HStack{
                Text("\(Image(systemName: "location.north")) Show Air Quality local to device:")
                Spacer()
                Text("\((ProfileEditor().AirQualityLocalToDevice) ? "On": "Off" )")
            }
            .font(.subheadline)
            
            HStack{
                Text("\(Image(systemName: "binoculars")) 1 Hour Forecast:")
                Spacer()
                Text("\((ProfileEditor().OneHourForecastDataWanted) ? "On": "Off" )")
            }
            .font(.subheadline)
            
            HStack{
                Text("\(Image(systemName: "bolt")) Electricty Consumption data:")
                Spacer()
                Text("\((ProfileEditor().ElectricalConsumptionDataWanted) ? "On": "Off" )")
            }
            .font(.subheadline)
            
            HStack{
                Text("\(Image(systemName: "car.2")) Telraam Traffic Data:")
                Spacer()
                Text("\((ProfileEditor().TelraamDataWanted) ? "On": "Off" )")
            }
            .font(.subheadline)
            
            HStack{
                Text("\(Image(systemName: "hand.wave")) Miasma Welcome Text:")
                Spacer()
                Text("\((ProfileEditor().ShowWelcomeText) ? "On": "Off" )")
            }
            .font(.subheadline)
            
            HStack{
                Text("Review / Feedback for Miasma")
                Spacer()
                Link("\(Image(systemName: "link.circle"))", destination: URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
            }
            .font(.subheadline)
            
            
//            HStack{
//                Text("WHO Air Quality Guidelines")
//                Spacer()
//                Link("\(Image(systemName: "link.circle"))", destination: URL(string: "https://www.who.int/publications/i/item/9789240034228?ua=1")!)
//            }
//            .font(.subheadline)
            
//                            Text("<- Best ✓ ④ ③ ② ① ⓪ Worst ->")
//                                .font(.subheadline)

            
            HStack{
                Text("About Miasma")
                Spacer()
                Link("\(Image(systemName: "link.circle"))", destination: URL(string: "https://miasma.app")!)
            }
            .font(.subheadline)
            
            HStack{
                Text("Version:")
                Spacer()
                Text("\((nsObject.self ?? 1.00 as AnyObject) as! String)")
            }
            .font(.subheadline)
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary()
    }
}
