//
//  GameViewModel.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import Foundation


class GameViewModel : ObservableObject{
    
    @Published var games = [Game]()
    
    init(){
        readJSON()
    }
    
    func readJSON(){
       
        let pathString = Bundle.main.path(forResource: "games", ofType: "json")
        if let path = pathString{
    
            let url = URL(fileURLWithPath: path)
            do{
                let json_data = try Data(contentsOf: url)
                let json_decoder = JSONDecoder()
                let jsonData =  try json_decoder.decode([Game].self, from: json_data)
                self.games = jsonData
                
            }catch{
                print(error)
            }
        }
    }
}
