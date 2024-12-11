////
////  MatchingPairs.swift
////  iOSProject
////
////  Created by Josh on 12/11/24.
////
//import SwiftUI
//import Foundation
//
//class PairsGameModel: ObservableObject {
//        
//        @Published private var playerCard = 0
//        @Published private var playerWins = 0
//        @Published private var numPairs = 6
//        
//    
//        @EnvironmentObject var deck : DeckViewModel
//        
//        var playerWinsStr : String{
//            get{
//                return String(playerWins)
//            }
//        }
//        
//        func getCardImage(card: Card) -> String{
//           return playerCard > 0 ? String("card\(playerCard)") :
//             "back"
//        }
//        
//        func getCards() -> [Card] {
//            let cards = deck.cards.shuffle()
//            return Array(cards.prefix(numPairs))
//        }
//
//        func getDoubledCards() -> [Card] {
//            let cards = getCards()
//            let doubledCards = cards + cards
//            return doubledCards.shuffle()
//        }
//    
//        func shuffle(cards: [Card]) -> [Card]{
//            for i in stride(from: cards.count, to: 0, by: -1){
//                let index = Int.random(in: 0 ..< i)
//                cards.swapAt(index, i)
//            }
//        }
//    }
//        
//
//}
//
//struct MatchingPairsView : View {
//    
//    @ObservedObject var pairsModel = PairsGameModel()
//    
//    var body: some View{
//        GeometryReader{ gp in
//            VStack(alignment: .leading){
//                Text("Matching Pairs")
//                    .bold()
//                    .font(.title)
//                
//                ScrollView{
//                    
//                    // GridItem(spacing) space between columns
//                    LazyVGrid(columns: [GridItem(spacing: 10), GridItem(spacing: 10), GridItem(spacing: 10)],
//                              spacing: 10){ // space between rows
//                        
//                        ForEach(pairsModel.getDoubledCards(), id: \.self){ card in
//                            
//                            Button {
//                                
//                            } label: {
//                                Image(photoName)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: (gp.size.width - 40)/3)
//                                    .clipped()
//                            }
//                            
//                        }
//                        
//                    }
//                }
//            }.padding(.horizontal, 10)
//        }
//    }
//}
