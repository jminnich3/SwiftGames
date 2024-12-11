//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI


struct cardList {
    var cards: [Card]
    
    mutating func addCard(card: Card){
        cards.append(card)
    }
}

struct PairsView : View {
    
    @EnvironmentObject var VM : DeckViewModel
    @State var bgColor: Color = Utility.beige
    @State var gameStarted = true;
    @State var gameQuit = false;
    @State var gameWon = false;
    @State var numberOfPairs : Int = 4
    @Binding var myCards: cardList
    
    var body: some View{
        
        
        // game side
        if(gameStarted){
            
            ZStack{
                Color(bgColor)
                VStack{
                    Spacer()
                    
                    HStack{
                        NavigationLink{
                            ContentView()
                        }label : {
                            ZStack{
                                RoundedRectangle(cornerRadius: 14)
                                    .foregroundStyle(Color.white)
                                    .frame(width: 50, height: 40)
                                Text("Quit")
                                    .bold()
                                    .foregroundStyle(.black)
                            }
                        }.padding(.horizontal)
                        Spacer()
                        Text("Matching Pairs")
                            .foregroundColor(.black)
                            .cornerRadius(20)
                            .bold()
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        
//                            .padding(.bottom, 115)
                    }
                    
                   
                    
                    
                    
                    Spacer()
                    
                    Spacer()
                    
                }
                .onAppear(){
                    self.VM.shuffle()
                }
                .padding()
                
            }.ignoresSafeArea()
            
        }
        
        // Intro View, game hasn't started
        else{
            ZStack{
                Color(bgColor)
                VStack{
                    Text("Matching Pairs")
                        .foregroundColor(.black)
                        .bold()
                        .cornerRadius(20)
                        .font(.system(size: 30))
                    Button{
                        gameStarted = true
                    }label : {
                        ZStack{
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundStyle(Color.white)
                                .frame(width: 200, height: 50)
                            Text("Play")
                                .bold()
                                .foregroundStyle(.black)
                        }
                    }.padding(.horizontal)
                        .padding(.bottom, 115)
                    
                }
                .padding()
                
            }.ignoresSafeArea()
        }
    }
    
    
    
    
}


//#Preview{
//    var cards: cardList
//    var VM : DeckViewModel
//    VM.shuffle()
//    for i in 1...5{
//        cards.addCard(card: VM.cards[i])
//    }
//    PairsView(bgColor: Utility.beige, myCards: cards)
//        .environmentObject(DeckViewModel())
//}
