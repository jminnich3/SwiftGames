//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI


struct PairsView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("Pairs")
    }
}


#Preview{
    GoFishView()
        .environmentObject(DeckViewModel())
}
