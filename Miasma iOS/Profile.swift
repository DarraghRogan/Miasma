/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An object that models a user profile.
*/
import Foundation

struct Profile {
    var username: String
    var prefersNotifications: Bool
    var goalDate: Date
    
    static let `default` = Self(username: "g_kumar", prefersNotifications: true)
    
    init(username: String, prefersNotifications: Bool = true) {
        self.username = username
        self.prefersNotifications = prefersNotifications
        self.goalDate = Date()
    }
    

}
