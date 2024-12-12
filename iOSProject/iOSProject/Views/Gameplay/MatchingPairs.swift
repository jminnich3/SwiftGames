////
////  MatchingPairs.swift
////  iOSProject
////
////  Created by Josh on 12/11/24.
////
//import SwiftUI
//import Foundation
//
////class PairsGameModel: ObservableObject {
////    
////        @Published private var timer = 0
////        @Published private var numPairs = 6
//////        @Published var sourceCards: [Card] = []
////        @Published var boardCards: [Card] = []
////        @Published var displayedBoardCards: [Card] = []
////        @Published var canFlip : Bool = false
////        @Published var pairsFound : Int = 0
////        @Published var userName : String = "jminnich23"
////        @Published var gamesWon : Int = 0
////        @Published var displayCards : Bool = false
////    
////        
////        @Published private var deck: [Card]
////        init(deck: [Card]) {
////            self.deck = deck
////        }
////        
////        func runGame(){
////            displayedBoardCards = []
////            boardCards = []
////            
////            timer = 0
////            canFlip = false
////            pairsFound = 0
////            
////            getCards()
////            shuffleBoardCards()
////            
////            createBoard()
////        }
////    
////        func createBoard(){
////            for i in stride(from: 0, to: boardCards.count, by: 1){
////                withAnimation(.easeInOut(duration: 1.5).delay(1)) {
////                    var card : Card = boardCards.removeFirst()
////                    displayedBoardCards.append(card)
////                }
////            }
////        }
////    
////        func getCards(){
////            for i in 1...numPairs*2{
//////                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 * Double(i)) {
////                    self.addCard(showCard: false)
//////                }
////            }
////
////            canFlip = true
////        }
////    
////        func addCard(showCard: Bool){
////            var dealCard : Card = deck.removeFirst()
////            dealCard.isShown = showCard
////            boardCards.append(dealCard)
////            boardCards.append(dealCard)
////        }
////        
////        // HELPERS THAT SHOULD WORK //
////        func cardImage(card: Card) -> String{
////            if (!card.isShown){
////                return ("back_of_blue")
////            }
////           return (card.suit == "joker" ? ("\(card.value)_\(card.suit)") :  "\(card.value)_of_\(card.suit)")
////        }
////    
////        func shuffleBoardCards(){
////            for i in stride(from: self.boardCards.count, to: 0, by: -1){
////                let index = Int.random(in: 0 ..< i)
////                self.boardCards.swapAt(index, i)
////            }
////        }
////    
////        func shuffle(){
////            for i in stride(from: self.deck.count-5, to: 0, by: -1){
////                let index = Int.random(in: 0 ..< i)
////                self.deck.swapAt(index, i)
////            }
////        }
////    
////    
////    //        func getCards() -> [Card] {
////    //            let cards = deck.cards.shuffle()
////    //            return Array(cards.prefix(numPairs))
////    //        }
////    //
////    //        func getDoubledCards() -> [Card] {
////    //            let cards = getCards()
////    //            let doubledCards = cards + cards
////    //            return doubledCards.shuffle()
////    //        }
////    
////}
//
//struct MatchingPairsView : View {
//    
//   
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
