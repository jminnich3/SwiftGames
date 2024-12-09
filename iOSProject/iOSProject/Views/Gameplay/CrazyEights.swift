//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI


struct CrazyEightsView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("Crazy 8s")
    }
}


#Preview{
    CrazyEightsView()
        .environmentObject(DeckViewModel())
}
