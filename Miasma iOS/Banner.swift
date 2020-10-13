//
//  Banner.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 12/10/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-4380200549840291/2043028652"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    var body: some View{
        HStack{
            Spacer()
            BannerVC().frame(width: 320, height: 50, alignment: .center)
            Spacer()
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
