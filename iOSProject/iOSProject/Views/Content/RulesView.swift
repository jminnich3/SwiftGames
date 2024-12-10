//
//  GamesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

import SwiftUI


struct RulesView : View {

    @EnvironmentObject var games :  GameViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(games.games){ game in
                        NavigationLink{
                            WebView(requestURL: URLRequest(url: URL(string:game.link)!))
                        } label:{
                            HStack {
                                Spacer()
                                Image(game.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(color: Color.black.opacity(0.2), radius: 6)
                                    .frame(width: 50)
                                Spacer()
                                Text(game.name)
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
                    }.frame(width: 400)
                        .navigationTitle("Rules")
                }
            }
        }
    }
}


#Preview{
    RulesView()
        //.environmentObject(DeckViewModel())
       .environmentObject(GameViewModel())
}
