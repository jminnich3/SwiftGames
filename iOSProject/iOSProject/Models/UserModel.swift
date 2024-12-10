//
//  UserModel.swift
//  iOSProject
//
//  Created by Josh Minnich on 12/10/24.
//

import Foundation
import CoreLocation

struct Coordinate: Decodable{
    var latitude: Double
    var longitude: Double
}

struct UserModel: Decodable, Identifiable {
    var id: String?
    var name: String?
    var areFriends: Bool?
    var coordinates: Coordinate?
    var favoriteGame: Game?
    var distance: Double?
    var phone: String?
    enum CodingKeys: CodingKey {
        case id
        case name
        case areFriends
        case coordinates
        case favoriteGame
        case distance
        case phone
    }
}
