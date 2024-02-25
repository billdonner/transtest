//
//  SwiftUIView.swift
//  transtest
//
//  Created by bill donner on 2/25/24.
//

import SwiftUI
 
// Define a difficulty level for the game

enum SampleTopics : String,CaseIterable,Identifiable {
  var id: String {self.rawValue}
  case Movies,Music,Television,History,Politics,Space,Underwater,Stocks,Trump

}
// Define a simple model for the onboarding slides
struct OnboardingSlide {
    let title: String
    let description: String
    let image: String
    let kind: SlideKind
  
  enum SlideKind : String,CaseIterable,Identifiable {
    var id: String {self.rawValue}
    case plain
    case levelPicker
    case topicPicker
  }
}

// Define a difficulty level for the game

enum DifficultyLevel : String,CaseIterable,Identifiable {
  var id: String {self.rawValue}
  case easy
  case medium
  case hard
}

// Define a simple base of slides for usage within onboarding presentation
let onboardingSlides = [
  OnboardingSlide(title: "Welcome to Q20K", description: "Play for a minute or an hour", image: "Onboarding1",kind:.plain),
  OnboardingSlide(title: "Choose Difficulty Level", description: "Easy plays 3 topics\nMedium plays 5 topics\nHard plays 7 topics", image: "gear",kind:.levelPicker),
  OnboardingSlide(title: "Pick Your Topics", description: "Choose first in group", image: "person.3",kind:.topicPicker),
  OnboardingSlide(title: "Here We Go", description: "Let’s get started", image: "person.3",kind:.plain)
]

// The main application view displayed after onboarding
struct SimulatedMainAppView: View {
    var body: some View {
        Text("Welcome to the Simulated Main App!")
            .padding()
    }
}
// Main App Entry
@main
struct OnboardingApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

// Root Content View, switching views based on onboarding completion
struct RootView: View {
    @AppStorage("onboardingCompleted") private var onboardingCompleted = false
    var body: some View {
        Group {
            if onboardingCompleted {
                SimulatedMainAppView()
            } else {
                InnerOnboardingView { onboardingCompleted = true }
            }
        }
    }
}



// Onboarding view that displays slides and a completion button on the last slide
struct InnerOnboardingView: View {
    var completion: () -> Void
    @State private var slideIndex = 0
    @State private var selectedLevel: OnboardingSlide.SlideKind = .plain
    @State private var selectedTopic : SampleTopics = .Movies
  func nextSlide() {
    if slideIndex == onboardingSlides.count - 1 {
      completion()
    } else {
      slideIndex += 1
    }
  }
    var body: some View {
        VStack {
          if slideIndex < onboardingSlides.count {
            singleSlideView(slide: onboardingSlides[slideIndex])
            switch onboardingSlides[slideIndex].kind {
              
            case .plain:
              Button("Next") {
                nextSlide()
              }.padding()
              
            case .levelPicker:
              VStack {
                Text("Select Difficulty:")
                  .font(.headline)
                Picker("Select Difficulty", selection: $selectedLevel) {
                  // Loop through all difficulty levels
                  ForEach(DifficultyLevel.allCases) { level in
                    Text(level.rawValue).tag(level).font(.largeTitle)
                  }
                }
                .pickerStyle(InlinePickerStyle())// You can adjust the picker style
                Button("Next") {
                  nextSlide()
                }.padding()
              .onChange(of: selectedLevel,initial:false) { val1,val2  in
                let _ =  print("Selected Level: \(val1.rawValue) \(val2.rawValue)")
              }
                Spacer()
              }
              .padding()
            case .topicPicker:
              VStack {
                Text("Select Topics:")
                  .font(.headline)
                Picker("Select First Topic", selection: $selectedTopic) {
                  // Loop through all difficulty levels
                  ForEach(SampleTopics.allCases) { level in
                    Text(level.rawValue).tag(level).font(.largeTitle)
                  }
                }
                .pickerStyle(InlinePickerStyle())// You can adjust the picker style
                Button("Next") {
                  nextSlide()
                }.padding()
              .onChange(of: selectedTopic,initial:false) { val1,val2  in
                let _ =  print("Selected Topic: \(val1.rawValue) \(val2.rawValue)")
              }
                Spacer()
              }
              .padding()
            }
          }
        }
        .transition(.slide)
        .animation(.default, value: slideIndex)
    }
    
    @ViewBuilder
    func singleSlideView(slide: OnboardingSlide) -> some View {
        VStack {
          if slide.image == slide.image.lowercased() {
            Image(systemName: slide.image)
              .resizable()
              .scaledToFit()
              .frame(width: 100, height: 100)
              .padding()
          } else {
            Image(slide.image)
              .resizable()
              .scaledToFit()
              .frame(width: 100, height: 100)
              .padding()
          }
            Text(slide.title)
                .font(.title)
                .padding()
            Text(slide.description)
                .padding()
        }
    }
}
struct OnboardingScreen: View {
  @State var isPresented = false
  var body: some View {
    InnerOnboardingView(){
      let _ = print("Done Onboarding")
      isPresented = true
    }
    .fullScreenCover (isPresented: $isPresented) {
      RootView()
    }
  }
}

#Preview {
  OnboardingScreen()
}
