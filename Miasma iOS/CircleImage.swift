/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that clips an image to a circle and adds a stroke and shadow.
*/

import SwiftUI

struct CircleImage: View {
    var body: some View {

        VStack {

            Image("iconForiOSBanner")
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.purple, lineWidth: 4))
                .shadow(radius: 10)
//                .opacity(0.7)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
