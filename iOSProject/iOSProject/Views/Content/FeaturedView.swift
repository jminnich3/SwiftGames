//
//  FeaturedView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

//
//  AboutView.swift
//  Restaurant
//
//  Created by David Zhang on 10/9/24.
//

import SwiftUI



struct FeaturedView: View {
    
    @EnvironmentObject var VM: GameViewModel
    @State var game1 : Game?

    var body: some View {
        
        VStack{
            Text("Featured Games")
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            TabView(){
                let featuredGames = VM.games.filter({ $0.featured })
                ForEach(featuredGames){ game in
                    FeaturedGameView(game: game)
                        .onAppear(){
                            game1 = game
                        }
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            if let selectedGame = game1{
                FeaturedGameInfo(game: selectedGame)
                    .padding(.bottom, 100)
                    .padding(.leading, 10)
            }
            
        }
    }

}


#Preview {
    FeaturedView()
        .environmentObject(GameViewModel())

}
