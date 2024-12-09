//
//  GamesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

import SwiftUI


struct GamesView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("Games")
    }
}


#Preview{
    GamesView()
        .environmentObject(DeckViewModel())
}
