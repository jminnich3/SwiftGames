//
//  DeckViewModel.swift
//  iOSProject
//
//  Created by COMP401 on 11/18/24.
//

//
//  ViewModel.swift
//  Restaurant
//
//  Created by David Zhang on 10/8/24.
//

import Foundation


class DeckViewModel : ObservableObject{
    
    @Published var deck = [Card]()
    
    init(){
        readJSON()
    }
    
    func readJSON(){
        
        // read json file and conform it to instances of the Pizza Object
        
        // 1. Get the path to the json file within the app bundle
        let pathString = Bundle.main.path(forResource: "deck_of_cards", ofType: "json")
        
        if let path = pathString{
            // 2. Create a url object
            let url = URL(fileURLWithPath: path)
            
            do{
                // 3. Create a Data Object with the URL file to fetch the data
                let json_data = try Data(contentsOf: url)
                
                // 4. parse the data with a decoder
                let json_decoder = JSONDecoder()
                
                let jsonData =  try json_decoder.decode([Card].self, from: json_data)
                
                self.deck = jsonData
                
            }catch{
                print(error)
            }
        }
    }
    
    
}
