//
//  ContentView.swift
//  transtest
//
//  Created by bill donner on 2/25/24.
//
import SwiftUI

struct FullMainView:View {
  var body: some View {
    Color.red
      .ignoresSafeArea()
  }
}
struct  AlienSplashView: View {
  let showMainView:Bool
    var body: some View {
        Image("Picture") // Use the custom launch image asset name here
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .opacity(showMainView ? 0 : 1)
    }
}
 
struct OuterView: View {

  
    @State private var showMainView = false
    
    var body: some View {
        ZStack {
            FullMainView()
                .opacity(showMainView ? 1 : 0) // Show one or the other
            VStack {
              AlienSplashView(showMainView: showMainView)
                    .opacity(showMainView ? 0 : 1)
            }
        }
        .onAppear {
            withAnimation(Animation.easeIn(duration:2.5).delay(0.5)) {
              showMainView = true // Start the transition
            }
        }
    }
}


 

#Preview {
  OuterView()
}
