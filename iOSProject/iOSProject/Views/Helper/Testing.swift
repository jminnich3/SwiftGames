//
//  Testing.swift
//  iOSProject
//
//  Created by Josh Minnich on 12/10/24.
//

import SwiftUI

// Tesitng some animations
struct Testing: View {
   
    @State private var showRectangle = false

// RECTANGLE COMING IN FROM THE LEFT
//       var body: some View {
//           VStack {
//               if showRectangle {
//                   Rectangle()
//                       .frame(width: 200, height: 200)
//                       .transition(.slide)
//               }
//               
//               Button("Toggle View") {
//                   withAnimation {
//                       showRectangle.toggle()
//                   }
//               }
//           }
//       }
    
//      COOL CIRCLE GETTING BIGGER
//        @State private var isScaled = false
//
//        var body: some View {
//            VStack {
//                Circle()
//                    .frame(width: 100, height: 100)
//                    .scaleEffect(isScaled ? 1.5 : 1.0)
//                    .animation(.easeInOut(duration: 1), value: isScaled)
//                
//                Button("Animate") {
//                    isScaled.toggle()
//                }
//                .padding()
//            }
//        }
    
// could use this for game rules or info? like before playign the game you hit the toggle to see more game info
    
//        @Namespace private var animation
//        @State private var isExpanded = false
//
//        var body: some View {
//            VStack {
//                if isExpanded {
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .matchedGeometryEffect(id: "rectangle", in: animation)
//                        .frame(width: 300, height: 200)
//                } else {
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .matchedGeometryEffect(id: "rectangle", in: animation)
//                        .frame(width: 100, height: 100)
//                }
//
//                Button("Toggle") {
//                    withAnimation(.spring()) {
//                        isExpanded.toggle()
//                    }
//                }
//            }
//        }

// Circle goes back to it's original place
//    @State private var dragOffset: CGSize = .zero
//
//        var body: some View {
//            Circle()
//                .frame(width: 100, height: 100)
//                .offset(dragOffset)
//                .animation(.spring(), value: dragOffset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            dragOffset = gesture.translation
//                        }
//                        .onEnded { _ in
//                            dragOffset = .zero
//                        }
//                )
//        }
    
        @State private var scale: CGFloat = 1.0
       @State private var rotation: Angle = .zero

       var body: some View {
           VStack {
               Text("Pinch and Rotate")
                   .font(.title)
                   .padding()

               RoundedRectangle(cornerRadius: 20)
                   .fill(Color.blue)
                   .frame(width: 200, height: 200)
                   .scaleEffect(scale)
                   .rotationEffect(rotation)
                   .gesture(
                       SimultaneousGesture(
                           MagnificationGesture()
                               .onChanged { value in
                                   scale = value
                               },
                           RotationGesture()
                               .onChanged { value in
                                   rotation = value
                               }
                       )
                   )
           }
       }

}

#Preview {
    Testing()
}
