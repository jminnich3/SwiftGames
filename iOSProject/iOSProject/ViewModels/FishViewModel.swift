//
//  FishViewModel.swift
//  iOSProject
//
//  Created by Lucas Sanderson on 12/12/24.
//

import Foundation





class FishViewModel : ObservableObject{
    
    @Published var cards = [FishCard]()
    
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
                let jsonData =  try json_decoder.decode([FishCard].self, from: json_data)
                self.cards = jsonData
                
            }catch{
                print(error)
            }
        }
    }
    
    func shuffle(){
        for i in stride(from: cards.count-5, to: 0, by: -1){
            let index = Int.random(in: 0 ..< i)
            cards.swapAt(index, i)
        }
    }
}
