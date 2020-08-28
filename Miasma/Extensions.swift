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
// https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjt04_w4-HqAhWUUhUIHY4SDq04ChC3AjAAegQIChAB&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DDiG4GXPvY2Q&usg=AOvVaw0yEan6xYrUXbc7qhbqkbx1

extension String {
    
    enum ValidityType {
        case purpleAirID
    }
    
    enum Regex: String {
        case purpleAirID = "[0-9]{4,5}"

    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .purpleAirID:
            regex = Regex.purpleAirID.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}
