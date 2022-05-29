//
//  BannerAdViewControllerRepresentable.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 28/05/2022.
//  Copyright © 2022 Darragh Rogan. All rights reserved.
//

import Foundation
import SwiftUI

final class BannerAd: UIViewControllerRepresentable {
    let adUnitId: String
    
    init(adUnitId: String) {
        self.adUnitId = adUnitId
    }
    
    
    func makeUIViewController(context: Context) -> BannerAdVC {
        return BannerAdVC(adUnitId: adUnitId)
    }

    func updateUIViewController(_ uiViewController: BannerAdVC, context: Context) {
        
    }
}
