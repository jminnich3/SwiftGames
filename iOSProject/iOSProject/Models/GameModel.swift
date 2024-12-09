//
//  GameModel.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//
import Foundation

struct GameModel : Decodable, Identifiable{
    var id : UUID = UUID()
    var games: [Game]
    
    enum CodingKeys : CodingKey{
        case games
    }
}

struct Game : Decodable, Identifiable{
    var id : UUID = UUID()
    var name : String
    var minAge: Int
    var minPlayers: Int
    var maxPlayers : Int
    var featured : Bool
    var similarGames : [String]
    var link : String
    var description : String
    var gameplay : [String]
    var image : String
    
    enum CodingKeys : CodingKey{
        case name
        case minAge
        case minPlayers
        case maxPlayers
        case featured
        case similarGames
        case link
        case description
        case gameplay
        case image
    }
}
