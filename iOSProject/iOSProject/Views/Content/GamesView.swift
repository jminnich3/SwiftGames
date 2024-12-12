//
//  GamesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

import SwiftUI


struct GamesView : View {

    @EnvironmentObject var games : GameViewModel
    @EnvironmentObject var deck : DeckViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    NavigationLink{
                        PairsView(deck: deck)
                            .environmentObject(deck)
                    } label:{
                        
                        HStack {
                            Spacer()
                            if let game = games.games.first {
                                Image(game.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(color: Color.black.opacity(0.2), radius: 6)
                                    .frame(width: 50)
                                Spacer()
                                Text(games.games[0].name)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .font(.system(size: 30))
                                Spacer()
                            }
                        }
                        .frame(width: 375, height: 65)
                        .padding(.bottom, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.4), radius: 10)
                    }.padding(.bottom, 5)
                    
                    NavigationLink{
                        CrazyEightsView()
                            .environmentObject(deck)
                    } label:{
                        
                        HStack {
                            Spacer()
                                Image(games.games[1].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(color: Color.black.opacity(0.2), radius: 6)
                                    .frame(width: 50)
                                Spacer()
                                Text(games.games[1].name)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .font(.system(size: 30))
                                Spacer()
                        }
                        .frame(width: 375, height: 65)
                        .padding(.bottom, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.4), radius: 10)
                    }.padding(.bottom, 5)
                    
                    NavigationLink{
                        GoFishView(deck: deck)
                            .environmentObject(deck)
                    } label:{
                        
                        HStack {
                            Spacer()
                                Image(games.games[2].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(color: Color.black.opacity(0.2), radius: 6)
                                    .frame(width: 50)
                                Spacer()
                                Text(games.games[2].name)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .font(.system(size: 30))
                                Spacer()
                        }
                        .frame(width: 375, height: 65)
                        .padding(.bottom, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.4), radius: 10)
                    }.padding(.bottom, 5)
                    
                    NavigationLink{
                        BlackJackView(deck: deck)
                            .environmentObject(deck)
                    } label:{
                        
                        HStack {
                            Spacer()
                                Image(games.games[3].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(color: Color.black.opacity(0.2), radius: 6)
                                    .frame(width: 50)
                                Spacer()
                                Text(games.games[3].name)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .font(.system(size: 30))
                                Spacer()
                        }
                        .frame(width: 375, height: 65)
                        .padding(.bottom, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.4), radius: 10)
                    }.padding(.bottom, 5)
                    
                }.navigationTitle("Games")
                    .frame(width: 400)
            }
        }
        
    }
}


#Preview{
    GamesView()
        .environmentObject(DeckViewModel())
       .environmentObject(GameViewModel())
}
