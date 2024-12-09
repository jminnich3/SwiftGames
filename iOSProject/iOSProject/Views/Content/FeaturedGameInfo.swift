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
            Text("Name: \(game.name)")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Avenir Heavy", size: 18))
                .padding(.leading, 15)
//            Text(game.name)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .font(.custom("Avenir", size: 18))
//                .padding(.leading, 15)
            
//            if let minAge = game.minAge{
//                Text("Minimum Age: \(minAge)")
//                    .bold()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .font(.custom("Avenir Heavy", size: 18))
//                    .padding(.leading, 15)
//            }
//            
//            if let minPlayers = game.minPlayers{
//                if let maxPlayers = game.maxPlayers{
//                    Text("Players: \(minPlayers) - \(maxPlayers)")
//                        .bold()
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(.custom("Avenir Heavy", size: 18))
//                        .padding(.leading, 15)
//                }
//            }
//            
//            if let similarGames = game.similarGames{
//                
//                HStack{
//                    Text("Similar Games: ")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(.custom("Avenir Heavy", size: 18))
//                        .padding(.leading, 15)
//                    
//                    ForEach(similarGames, id: \.self){game in
//                        Text("\(game)")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.custom("Avenir Heavy", size: 18))
//                            .padding(.leading, 15)
//                        }
//                }
//            }
           
        }
    }
}
