//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI


struct BlackJackView : View {

    @EnvironmentObject var VM : DeckViewModel
    @State var bgColor: Color = Color(red: 0.06, green: 0.37, blue: 0.06)
    @State var numberOfPairs : Int? = nil
    
    var body: some View{
        
        ZStack{
            Color(bgColor)
            VStack{
                Spacer()
                Text("Black Jack")
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .font(.system(size: 30))
                Text("Leaderboard")
                    .foregroundColor(.white)
                Spacer()
                Text("Dealer Hand")
                    .foregroundColor(.white)
                Spacer()
                Text("DEAL")
                    .foregroundColor(.white)
                Text("HIT")
                    .foregroundColor(.white)
                Text("STAND")
                    .foregroundColor(.white)
                Spacer()
                
//                TextField("Number of Pairs", : Binding(
//                    get: {
//                        numberOfPairs ?? 5// Provide a default value if nil
//                    },
//                    set: {
//                        numberOfPairs = $0 // Update the optional email
//                    }
//                ))
            }
            .padding()
            
        }.ignoresSafeArea()
        
        
    }
}


#Preview{
    BlackJackView()
        .environmentObject(DeckViewModel())
}
