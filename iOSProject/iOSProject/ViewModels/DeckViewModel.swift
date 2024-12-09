//
//  DeckViewModel.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/18/24.
//

import Foundation


class DeckViewModel : ObservableObject{
    
    @Published var deck = [Card]()
    
    init(){
        readJSON()
    }
    
    func readJSON(){
       
        let pathString = Bundle.main.path(forResource: "deck_of_cards", ofType: "json")
        if let path = pathString{
    
            let url = URL(fileURLWithPath: path)
            do{
                let json_data = try Data(contentsOf: url)
                let json_decoder = JSONDecoder()
                let jsonData =  try json_decoder.decode([Card].self, from: json_data)
                self.deck = jsonData
                
            }catch{
                print(error)
            }
        }
    }
}
