//
//  Oboarding.swift
//  iOSProject
//
//  Created by Josh on 12/10/24.
//

import SwiftUI

struct OnboardingViewDetails : View {
    var bgColor : Color
    var headline: String = ""
    var subHeadline :  String = ""
    var buttonAction : () -> Void // place holder for an action
    var image : String = ""
    
    var body: some View {
        ZStack{
            Color(bgColor)
            VStack(spacing: 0){
                Spacer()
                Spacer()
                Image(image)
                    .resizable()
                    .clipped()
                    .frame(width:250, height:250)
                
                Text(headline)
                    .font(Font.system(size: 22))
                    .bold()
                    .padding(.top, 32)
                
                Text(subHeadline)
                    .padding(.horizontal)
                    .padding(.top, 4)
                
                Spacer()
                
                Button{
                    buttonAction() // run the function
                }label : {
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundStyle(Color.white)
                            .frame(height: 50)
                        Text("Continue")
                            .bold()
                            .foregroundStyle(.black)
                    }
                }.padding(.horizontal)
                .padding(.bottom, 115)
                
                
            }.foregroundStyle(.white)
        }
            .ignoresSafeArea()
    }
}

struct OnboardingView: View {
    @EnvironmentObject var locVM : LocationModel
    @State var selectedViewIndex = 0
    @Environment(\.dismiss) var dismiss // get the instance of the dismiss function
    
    var body: some View {
        
        ZStack {
            
            TabView (selection: $selectedViewIndex) {
                
                OnboardingViewDetails(bgColor: Color(
                    red: 70 / 255.0,
                    green: 180 / 255.0,
                    blue: 138 / 255.0,
                    opacity: 255 / 255.0),
                                      headline: "Welcome to Card Stack Games!",
                                      subHeadline: "Card Stack is the place to play",
                                        image: "logo"){
                  
                    withAnimation {
                     selectedViewIndex = 1
                    }
                }
                .tag(0)
                
                OnboardingViewDetails(bgColor: Color(red: 0.06, green: 0.37, blue: 0.06),
                                      headline: "Play Classic Games",
                                      subHeadline: "We’ll connect you other players in your area",
                                      image: "CasinoChips") {
                    // button Action
                    withAnimation {
                     selectedViewIndex = 2
                    }
                }
                .tag(1)
                
                OnboardingViewDetails(bgColor: Color(red: 0.75, green: 0.5, blue: 0.5),
                                      headline: "Find New Friends",
                                      subHeadline: "We’ll connect you other players in your area",
                                      image: "map"){
                    withAnimation {
                     selectedViewIndex = 3
                    }
                }
                .tag(2)
                
                OnboardingViewDetails(bgColor: Color(red: 139/255, green: 166/255, blue: 65/255),
                                      headline: "Compete For Bragging Rights",
                                      subHeadline: "We’ll rank your success on the leaderboard!") {
                    // button Action
                    dismiss()
                }
                .tag(3)
            }
            // .tabViewStyle(.page(indexDisplayMode: .always))
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
            // how to lift up the dots
            VStack {
                Spacer()
                HStack (spacing: 16) {
                    Spacer()
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 0 ? .white : .gray)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 1 ? .white : .gray)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 2 ? .white : .gray)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 3 ? .white : .gray)
                    Spacer()
                }
                .padding(.bottom, 220)
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
