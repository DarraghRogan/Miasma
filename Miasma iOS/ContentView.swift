//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import CoreLocation

public struct ContentView: View {
    
//    @StateObject var locationViewModel = LocationViewModel()
    
    @State var showingProfile = false
    
    @State var ProgressIndicatorShown = true
    
    @State var airQualityDataSource: String = ProfileEditor().AirQualityDataSource
    
    public var body: some View {
                
        VStack {
            
            switch (airQualityDataSource) {
            case _ where airQualityDataSource == "WAQI/AQICN" :
                ContentViewWAQI()
            case _ where airQualityDataSource == "PurpleAir" :
                ContentViewPurpleAir()
            case _ where airQualityDataSource == "SmartCitizen" :
                ContentViewSmartCitizen()
            default:
                Link("Miasma ⇀",
                     destination: URL(string: "https://miasma.app")!)
                    .font(.headline)
            }
            
            Spacer()
            
            SwiftUIBannerAd(adPosition: .bottom, adUnitId: "ca-app-pub-4380200549840291/2043028652")
                .frame(height: 52)
            
            
//            switch locationViewModel.authorizationStatus {
//            case .notDetermined:
//                AnyView(RequestLocationView())
//                    .environmentObject(locationViewModel)
//            case .restricted:
//                ErrorView(errorText: "Location use is restricted.")
//            case .denied:
//                ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
//            case .authorizedAlways, .authorizedWhenInUse:
//                TrackingView()
//                    .environmentObject(locationViewModel)
//            default:
//                Text("Unexpected status")
//            }
            
        }
//        .overlay((CircleImage()
//                    .offset(x: 0, y: 0)), alignment: .center)
        .overlay((Button("\(Image(systemName: "gearshape.fill"))", action: { self.showingProfile.toggle() } )
                    .padding(EdgeInsets())
                    .offset(x: 125, y: 15)
                    .font(.system(size: 60))), alignment: .top)
                    .foregroundColor(.primary)
        
        
//        .edgesIgnoringSafeArea(.top)
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .gray]), startPoint: .leading, endPoint: .trailing))
        .sheet(isPresented: $showingProfile,
               onDismiss: {
                if ProfileEditor().AirQualityDataSource == "WAQI/AQICN"{
                    airQualityDataSource = "WAQI/AQICN"
                    ContentViewWAQI().updateListEntry()
                }
                else if ProfileEditor().AirQualityDataSource == "PurpleAir"{
                    airQualityDataSource = "PurpleAir"
                    ContentViewPurpleAir().updateListEntry()
                }
                else if ProfileEditor().AirQualityDataSource == "SmartCitizen"{
                    airQualityDataSource = "SmartCitizen"
                    ContentViewPurpleAir().updateListEntry()
                }
               }) {
            ProfileHost()
        }
    }
}

//struct RequestLocationView: View {
//    @EnvironmentObject var locationViewModel: LocationViewModel
//
//    var body: some View {
//        VStack {
//            Image(systemName: "location.circle")
//                .resizable()
//                .frame(width: 100, height: 100, alignment: .center)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//            Button(action: {
//                locationViewModel.requestPermission()
//            }, label: {
//                Label("Allow tracking", systemImage: "location")
//            })
//            .padding(10)
//            .foregroundColor(.white)
//            .background(Color.blue)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            Text("We need your permission to track you.")
//                .foregroundColor(.gray)
//                .font(.caption)
//        }
//    }
//}


struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TrackingView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel


    var body: some View {
        VStack {
            VStack {
                PairView(
                    leftText: "Latitude:",
                    rightText: String(coordinate?.latitude ?? 0)
                )
                PairView(
                    leftText: "Longitude:",
                    rightText: String(coordinate?.longitude ?? 0)
                )
                PairView(
                    leftText: "Altitude",
                    rightText: String(locationViewModel.lastSeenLocation?.altitude ?? 0)
                )
                PairView(
                    leftText: "Speed",
                    rightText: String(locationViewModel.lastSeenLocation?.speed ?? 0)
                )
                PairView(
                    leftText: "Country",
                    rightText: locationViewModel.currentPlacemark?.country ?? ""
                )
                PairView(leftText: "City", rightText: locationViewModel.currentPlacemark?.administrativeArea ?? ""
                )
            }
            .padding()
        }
    }

    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
}

struct PairView: View {
    let leftText: String
    let rightText: String
    
    var body: some View {
        HStack {
            Text(leftText)
            Spacer()
            Text(rightText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.sizeCategory, .small)
        }
    }
}

