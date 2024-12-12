//
//  DeckModel.swift
//  iOSProject
//
//  Created by COMP401 on 11/18/24.
//

import Foundation

class DeckModel: Decodable, Identifiable, ObservableObject{
    var id : UUID? = UUID()
    var deck: [Card]
    
    enum CodingKeys : CodingKey{
        case deck
    }
}

struct Card: Decodable, Identifiable, Hashable{
    var id : UUID? = UUID()
    var suit : String
    var value : String
    var isShown : Bool = false
    var image : String?
    var numericValue: Int {
        switch value {
        case "jack", "queen", "king":
            return 10
        case "ace":
            return 11
        default:
            return Int(value) ?? -1
        }
    }
    
    enum CodingKeys: CodingKey {
        case suit
        case value
    }
}
