//
//  ContentView.swift
//  MathQuiz
//
//  Created by Asif Sheikh on 9/21/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
//      ClickListView()
      QuizView(questions: Question.questionBank())
//      QuestionView(question: Question.randomAddition()) { _, _ in }
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
