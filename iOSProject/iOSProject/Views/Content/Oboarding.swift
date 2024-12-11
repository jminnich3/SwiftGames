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
    var image : String = ""
    var width : CGFloat = 0
    var height : CGFloat = 0
    var buttonAction : () -> Void // place holder for an action
   
    
    var body: some View {
        ZStack{
            Color(bgColor)
            VStack(spacing: 0){
                Spacer()
                Spacer()
                Image(image)
                    .resizable()
                    .clipped()
                    .frame(width:width, height:height)
                
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
                
                OnboardingViewDetails(bgColor: Utility.mintGreen,
                                      headline: "Welcome to Card Stack Games!",
                                      subHeadline: "Card Stack is the place to play",
                                    image: "logo",
                                      width: 350,
                                      height: 400){
                  
                    withAnimation {
                     selectedViewIndex = 1
                    }
                }
                .tag(0)
                
                OnboardingViewDetails(bgColor: Utility.forestGreen,
                                      headline: "Play Classic Games",
                                      subHeadline: "We’ll connect you other players in your area",
                                      image: "cardsVector",
                                      width: 350,
                                      height: 350) {
                    // button Action
                    withAnimation {
                     selectedViewIndex = 2
                    }
                }
                .tag(1)
                
                OnboardingViewDetails(bgColor: Utility.beige,
                                      headline: "Find New Friends",
                                      subHeadline: "We’ll connect you other players in your area",
                                      image: "map",
                                      width: 400,
                                      height: 300){
                    withAnimation {
                     selectedViewIndex = 3
                    }
                }
                .tag(2)
                
                OnboardingViewDetails(bgColor: Utility.charcoalGray,
                                      headline: "Compete For Bragging Rights",
                                      subHeadline: "We’ll rank your success on the leaderboard!", image: "leaderboardEdited2", width: 300,
                                      height: 300){
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
