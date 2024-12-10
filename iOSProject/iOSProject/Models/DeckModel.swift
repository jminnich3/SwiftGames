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

struct Card: Decodable, Identifiable{
    var id : UUID? = UUID()
    var suit : String
    var value : String
    
    enum CodingKeys: CodingKey {
        case suit
        case value
    }
}
