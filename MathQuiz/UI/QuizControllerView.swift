import SwiftUI

struct QuizControllerView: View {

  private var questions: [Question] = Question.questionBank()

//  @State private var previousScore: QuizScore? = QuizScore(date: Date(), numQuestions: 20, timeTaken: 78.3, numMistakes: Int.random(in: 0..<2))
  @State private var previousScore: QuizScore? = nil
  @State private var quizState: QuizState = .notstarted
  @State private var attempts: [Int] = []
  @State private var startTime: Date = Date()

  var body: some View {
    VStack {
      if (quizState == .notstarted) {
        startView()
      } else if (quizState == .finished) {
        let timeTaken = Date().timeIntervalSince(startTime)
        ResultsView(quizState: $quizState,
                    previousScore: $previousScore,
                    questions: questions,
                    attempts: attempts,
                    timeTaken: timeTaken)
      } else {
        QuizView(questions: questions,
                 quizState: $quizState,
                 attempts: $attempts)
      }
    }
    .onAppear {
      if let score = QuizScore.load() {
        previousScore = score
      }
    }
  }

  private func startView() -> some View {
    VStack(spacing: 20) {
      Button("Start New Quiz") {
        withAnimation {
          startTime = Date()
          attempts = Array(repeating: 0, count: questions.count)
          quizState = .started
        }
      }
      .padding()
      .padding([.leading, .trailing], 20)
      .font(.largeTitle)
      .foregroundColor(.white)
      .background(.blue)
      .clipShape(Capsule())

      if let score = previousScore {
        VStack(alignment: .center, spacing: 10) {
          Text("Previous Attempt")
            .font(.title)

          let formattedTime = Duration.seconds(score.timeTaken)
            .formatted(.time(pattern: .minuteSecond))
          Text("\(formattedTime)s")
            .font(.title)
            .bold()

          if (score.numMistakes > 0) {
            Text("\(score.numMistakes) mistake\(score.numMistakes == 1 ? "" : "s")")
              .font(.title)
              .foregroundColor(.red)
          } else {
            Text("No mistakes!")
              .font(.title)
              .bold()
              .foregroundColor(.green)
          }
        }
        .padding(.top, 120)
      }

      Spacer()
    }
    .padding(.top, 100)
  }

}

struct QuizControllerView_Previews: PreviewProvider {
  static var previews: some View {
    QuizControllerView()
  }
}
