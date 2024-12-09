//
//  FeaturedView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

//
//  AboutView.swift
//  Restaurant
//
//  Created by David Zhang on 10/9/24.
//

import SwiftUI

enum TABINDEX {
    case featured, list
}

struct Model{
    var state = "featured" // set up the default tabview
}

struct FeaturedView: View {
    
    @EnvironmentObject var VM: GameViewModel
    @State var game1 : Game?
//
    var body: some View {
        
        VStack{
            Text("Featured Games")
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
//
//            TabView(){
//                let featuredRecipes = VM.recipeArray.filter({ $0.featured })
//                ForEach(featuredRecipes){ recipe in
//                    FeaturedRecipeView(recipe: recipe)
//                        .onAppear(){
//                            recipe1 = recipe
//                        }
//
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//
//            if let selectedRecipe = recipe1{
//                FeaturedRecipeInfo(recipe: selectedRecipe)
//                    .padding(.bottom, 20)
//                    .padding(.leading, 10)
//            }
//
//        }
//
    }
}

#Preview {
    FeaturedView()
        .environmentObject(GameViewModel())
//        .environmentObject(/*RecipeViewModel*/())
}
