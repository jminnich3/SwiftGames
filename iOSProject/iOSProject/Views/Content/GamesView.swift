//
//  GamesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

import SwiftUI


struct GamesView : View {

   // @EnvironmentObject var VM : DeckViewModel
    @EnvironmentObject var games: GameViewModel
    
    var body: some View{
        Text("Games")
        
        VStack{
            Text("\(games.games.count)")
//            ForEach(games.games){ game in
//                Text(game.name)
//                Text(game.minAge)
//            }
        }
    }
}


#Preview{
    GamesView()
        //.environmentObject(DeckViewModel())
        .environmentObject(GameViewModel())
}
