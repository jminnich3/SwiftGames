//
//  GamesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

import SwiftUI


struct GamesView : View {

   // @EnvironmentObject var VM : DeckViewModel
    @ObservedObject var games =  GameViewModel()
    
    var body: some View{
        Text("Games")
        
        VStack{
        
            ForEach(games.games){ game in
                HStack{
                    Text(game.name)
                    Text("\(game.minAge)")
                    Image(game.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                }
                
            }
        }
    }
}


#Preview{
    GamesView()
        //.environmentObject(DeckViewModel())
        .environmentObject(GameViewModel())
}
