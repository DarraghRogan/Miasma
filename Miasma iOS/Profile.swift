/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An object that models a user profile.
*/
import Foundation

struct Profile {
    var sensorID: String
    var prefersNotifications: Bool
    var goalDate: Date
    
    static let `default` = Self(sensorID: "59111", prefersNotifications: true)
    
    init(sensorID: String, prefersNotifications: Bool = true) {
        self.sensorID = sensorID
        self.prefersNotifications = prefersNotifications
        self.goalDate = Date()
    }
    

}
