//
//  DataManager.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

public class DataManager {
    func loadData()
    {
        DataLoaderWAQI().loadWAQIData(id: "here")
        print(wAQIData.data?.aqi ?? 0)
    }
}
