//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI


struct BlackJackView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("BlackJack")
    }
}


#Preview{
    BlackJackView()
        .environmentObject(DeckViewModel())
}
