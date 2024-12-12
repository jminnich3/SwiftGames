//
//  FishDeckModel.swift
//  iOSProject
//
//  Created by Lucas Sanderson on 12/12/24.
//

import Foundation

class FishDeckModel: Decodable, Identifiable, ObservableObject{
    var id : UUID? = UUID()
    var deck: [Card]
    
    enum CodingKeys : CodingKey{
        case deck
    }
}

struct FishCard: Decodable, Identifiable, Hashable{
    var id : UUID? = UUID()
    var suit : String
    var value : String
    var isShown : Bool = false
    var image : String?
    //for giving a card or being asked for one "example: got any threes?"
    var canGiveUp: Bool = false

  
    var numericValue: Int {
        switch value {
        case "jack":
            return 11
        case "queen":
            return 12
       case "king":
            return 13
        case "ace":
            return 14
        default:
            return Int(value) ?? -1
        }
    }
    
    enum CodingKeys: CodingKey {
        case suit
        case value
    }
}
