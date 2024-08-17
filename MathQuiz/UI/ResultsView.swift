import SwiftUI

struct ResultsView: View {

  @Binding private var quizState: QuizState
  @Binding private var previousScore: QuizScore?

  let questions: [Question]
  let attempts: [Int]
  let timeTaken: TimeInterval

  let formattedTime: String
  let multiAttempts: [(Question, Int)]

  init(quizState: Binding<QuizState>,
       previousScore: Binding<QuizScore?>,
       questions: [Question],
       attempts: [Int],
       timeTaken: TimeInterval) {
    assert(questions.count == attempts.count)

    _quizState = quizState
    _previousScore = previousScore

    self.questions = questions
    self.attempts = attempts
    self.timeTaken = timeTaken

    let duration: Duration = .seconds(timeTaken)
    self.formattedTime = duration.formatted(.time(pattern: .minuteSecond))

    var multiAttempts: [(Question, Int)] = []
    for i in 0..<attempts.count {
      if (attempts[i] > 1) {
        multiAttempts.append((questions[i], attempts[i]))
      }
    }

    print(attempts)
    print(multiAttempts)
    print(multiAttempts.count)
    self.multiAttempts = multiAttempts
  }

  var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("Time taken\n\(formattedTime)s")
          .font(.largeTitle)
          .bold()

        if (multiAttempts.count == 0) {
          Image("woohoo")
            .resizable()
            .scaledToFit()
        } else {
          VStack {
            ForEach(0..<questions.count, id: \.self) { i in
              let question = questions[i]
              let attempts = attempts[i]
              if (attempts > 1) {
                HStack {
                  Text(question.text)
                    .font(.title)
                  Spacer()
                  Text("\(attempts) attempts")
                    .foregroundColor(.red)
                    .font(.title)
                }
                .padding([.leading, .trailing], 40)
              }
            }
          }
          .padding([.top, .bottom], 40)

//          List(multiAttempts, id: \.0) { multiAttempt in
//            ForEach(0..<multiAttempts.count, id: \.self) { i in
//              let question = multiAttempt.0
//              let attempts = multiAttempt.1
//              HStack {
//                Text(question.text)
//                Spacer()
//                Text("\(attempts) attempts")
//                  .foregroundColor(.red)
//              }
//            }
//          }
        }

        Button("Done") {
          let score = QuizScore(date: Date(), numQuestions: questions.count, timeTaken: timeTaken, numMistakes: attempts.reduce(0, &+) - questions.count)

          previousScore = score
          quizState = .notstarted
        }
        .padding(10)
        .padding([.leading, .trailing], 20)
        .font(.title)
        .foregroundColor(.white)
        .background(.blue)
        .clipShape(Capsule())
      }
      .padding(.top, 20)
    }
    .onAppear {
      let score = QuizScore(date: Date(), numQuestions: questions.count, timeTaken: timeTaken, numMistakes: attempts.reduce(0, &+) - questions.count)
      score.save()
    }
  }
}

struct ResultsView_Previews: PreviewProvider {
  static var previews: some View {
    @State var quizState: QuizState = .finished
    @State var previousScore: QuizScore? = QuizScore(date: Date(), numQuestions: 20, timeTaken: 78.3, numMistakes: Int.random(in: 1..<3))
    ResultsView(quizState: $quizState,
                previousScore: $previousScore,
                questions: Question.questionBank(),
                attempts: [1, 2, 1, 2],
                timeTaken: 34.2)
  }
}
