//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI


struct GoFishView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("GoFish")
    }
}


#Preview{
    GoFishView()
        .environmentObject(DeckViewModel())
}
