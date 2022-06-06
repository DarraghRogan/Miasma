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
            
            VStack{
                HStack{
                    Text("\(Image(systemName: "stethoscope")) WHO Air Quality Guidelines")
                    Spacer()
                    Link("\(Image(systemName: "link.circle"))", destination: URL(string: "https://www.who.int/publications/i/item/9789240034228?ua=1")!)
                }
                .font(.subheadline)
                
                Text("<- Best ✓ ④ ③ ② ① ⓪ Worst ->")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            VStack{
                HStack{
                    Text("☁️ Air Quality Index explanation")
                    Spacer()
                    Link("\(Image(systemName: "link.circle"))", destination: URL(string: "https://m.wikipedia.org/wiki/Air_quality_index#United_States")!)
                }
                .font(.subheadline)
                
                Text("<- Best 🟢🟡🟠🔴🟣🟤 Worst ->")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
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
            
//            HStack{
//                Text("\(Image(systemName: "hand.wave")) Miasma Welcome Text:")
//                Spacer()
//                Text("\((ProfileEditor().ShowWelcomeText) ? "On": "Off" )")
//            }
//            .font(.subheadline)
            
            HStack{
                Text("\(Image(systemName: "person.wave.2")) Review / Give Feedback")
                Spacer()
                Link("\(Image(systemName: "link.circle"))", destination: URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
            }
            .font(.subheadline)
                        
            HStack{
                Text("\(Image(systemName: "gear.badge.questionmark")) About Miasma (Version \((nsObject.self ?? 1.00 as AnyObject) as! String))")
                Spacer()
                Link("\(Image(systemName: "link.circle"))", destination: URL(string: "https://miasma.app")!)
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
