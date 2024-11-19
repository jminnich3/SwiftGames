//
//  RulesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//


import SwiftUI


struct RulesView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("Rules")
    }
}


#Preview{
    RulesView()
        .environmentObject(DeckViewModel())
}
