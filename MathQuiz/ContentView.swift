//
//  ContentView.swift
//  MathQuiz
//
//  Created by Asif Sheikh on 9/21/23.
//

import SwiftUI

struct ContentView: View {
  @State var attempts: [Int] = Array(repeating: 0, count: 4)

  var body: some View {
    VStack {
//      ClickListView()
//      QuizView(questions: Question.questionBank(), attempts: $attempts)
//      QuestionView(question: Question.randomAddition()) { _, _ in }

      QuizControllerView()
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
