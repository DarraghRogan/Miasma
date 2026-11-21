//
//  Extensions.swift
//  RegexMania
//
//  Created by Alex Nagy on 12/02/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import Foundation

// more info here https://emailregex.com/regular-expressions-cheat-sheet/ & here:
// https://stackoverflow.com/questions/13476060/validating-youtube-url-using-regex/41988283#41988283
// https://stackoverflow.com/questions/8650007/regular-expression-for-twitter-username
// https://sproutsocial.com/insights/social-media-character-counter/#instagram

extension String {
    
    enum ValidityType {
        case purpleAirID
        case wAQICity
        case smartCitizenStationID
        case sensorCommunityStationID
        case telraamSegmentID
    }
    
    enum Regex: String {
        case purpleAirID = "[0-9]{4,6}"
        case smartCitizenStationID = "[0-9]{3,5}"
        case sensorCommunityStationID = "[0-9]{3,6}"
        case telraamSegmentID = "[0-9]{5,10}"
        case wAQICity = "^[a-zA-Z]*$"
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .purpleAirID:
            regex = Regex.purpleAirID.rawValue
        case .wAQICity:
            regex = Regex.wAQICity.rawValue
        case .smartCitizenStationID:
            regex = Regex.smartCitizenStationID.rawValue
        case .sensorCommunityStationID:
            regex = Regex.sensorCommunityStationID.rawValue
        case .telraamSegmentID:
            regex = Regex.telraamSegmentID.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}
