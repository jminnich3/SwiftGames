//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI




struct PairsView : View {

    @EnvironmentObject var VM : DeckViewModel
    @State var bgColor: Color = Color(red: 0.6, green: 1.0, blue: 0.8)
    @State var numberOfPairs : Int? = nil
    
    var body: some View{
        
        ZStack{
            Color(bgColor)
            VStack{
                Text("Matching Pairs")
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .font(.system(size: 30))
                
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
    PairsView()
        .environmentObject(DeckViewModel())
}
