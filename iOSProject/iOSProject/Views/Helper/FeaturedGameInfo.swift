//
//  FeaturedGameInfo.swift
//  iOSProject
//
//  Created by Josh on 12/8/24.
//

import SwiftUI

struct FeaturedGameInfo : View{
    
    var game : Game
    
    var body : some View{
        VStack{
            Text("\(game.name)")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Avenir Heavy", size: 22))
                .padding(.leading, 15)
     
            Text("Players: \(game.minPlayers) - \(game.maxPlayers)")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Avenir", size: 18))
                    .padding(.leading, 15)
            
            Text("Minimum Age: \(game.minAge)")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Avenir Heavy", size: 18))
                    .padding(.leading, 15)
        
            
            
           
        }
    }
}
