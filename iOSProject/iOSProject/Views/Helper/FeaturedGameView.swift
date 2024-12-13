//
//  FeaturedGameView.swift
//  iOSProject
//
//  Created by Josh on 12/8/24.
//

import SwiftUI

struct FeaturedGameView : View{
    
    var game : Game
    
    @State var sheetOn : Bool = false
    
    var body: some View {
            VStack {
                Button{
                    sheetOn = true
                }label:{
                    VStack {
                        Image(game.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 365, height: 365)
                            .clipped()
                            .shadow(color: Color.black.opacity(0.2), radius: 6)
                        
                        Text(game.name)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(20)
                    }
                    .padding(.bottom,10)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(1), radius: 10)
                }.padding(.bottom, 30)
            }.sheet(isPresented: $sheetOn){
                //GameView(game: game)
            }
        
    }
}
