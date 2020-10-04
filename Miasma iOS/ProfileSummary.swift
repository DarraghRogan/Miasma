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
                Text("\(self.profile.sensorID)")
                Spacer()
                Text(profile.sensorID)
            }
            Text("Electricty Consumption data: \(self.profile.prefersNotifications ? "On": "Off" )")
            Text("Aircraft Overhead data: \(self.profile.prefersNotifications ? "On": "Off" )")
            Text("Notifications: \(self.profile.prefersNotifications ? "On": "Off" )")
            Button("Review / Suggest Improvements for Miasma", action: {
                print("refresh")
            })
            Button("About Miasma", action: {
                print("refresh")
            })
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
