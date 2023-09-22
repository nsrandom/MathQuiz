import SwiftUI

struct QuizControllerView: View {

  private var questions: [Question] = Question.questionBank()

  @State private var quizState: QuizState = .notstarted
  @State private var attempts: [Int] = []
  @State private var startTime: Date = Date()

  var body: some View {
    if (quizState == .notstarted) {
      startView()
    } else if (quizState == .finished) {
      let timeTaken = Date().timeIntervalSince(startTime)
      ResultsView(questions: questions, attempts: attempts, timeTaken: timeTaken)
    } else {
      QuizView(questions: questions,
               quizState: $quizState,
               attempts: $attempts)
    }
  }

  private func startView() -> some View {
    Button("Start Quiz") {
      withAnimation {
        startTime = Date()
        attempts = Array(repeating: 0, count: questions.count)
        quizState = .started
      }
    }
  }

}

struct QuizControllerView_Previews: PreviewProvider {
  static var previews: some View {
    QuizControllerView()
  }
}
