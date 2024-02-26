//
//  SimulatedMainAppView.swift
//  transtest
//
//  Created by bill donner on 2/25/24.
//

import SwiftUI

// The main application view displayed after onboarding
struct SimulatedMainAppView: View {
  @AppStorage("level")  var selectedLevel: DifficultyLevel = .medium
  @AppStorage("topic")  var selectedTopic : SampleTopics = .Movies
  var body: some View {
    ZStack {
      FullMainView()
      VStack {
        Text("Welcome to the Simulated Main App!")
        Text("level is \(selectedLevel) ;  topic is \(selectedTopic)")
          .padding()
      }
    }
  }
}

#Preview {
    SimulatedMainAppView()
}
